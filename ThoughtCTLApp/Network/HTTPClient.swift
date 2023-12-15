//
//  HTTPClient.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation
import Combine

protocol HTTPClientProtocol{
    func getData<T:Decodable>(request:URLRequest, responseType:T.Type)->Future<T, Error>
}



final class HTTPClient:HTTPClientProtocol{
    static let shared = HTTPClient()
    let decoder = JSONDecoder()
    var cancellable = Set<AnyCancellable>()
    let session = URLSession(configuration: .default)
    private init(){}
    
    func getData<T:Decodable>(request:URLRequest, responseType:T.Type)->Future<T, Error>{
        return Future(){ [self]promise in
            URLSession.DataTaskPublisher(request: request, session: session)
                .tryMap({ data, response in
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode)
                    else {throw(ApiError.badResponse)}
                    return data
                })
                .decode(type: responseType, decoder: JSONDecoder())
                .sink { completion in
                    switch (completion){
                    case .finished:
                        print("Do nothing")
                    case .failure(let error):
                        let errorInfo = "\(error)"
                        promise(.failure(ApiError.otherError(msg:errorInfo)))
                    }
                }
                receiveValue: { value in
                    promise(.success(value))
                }.store(in: &cancellable)

        }
    }
}
