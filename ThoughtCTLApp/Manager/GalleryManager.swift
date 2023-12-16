//
//  GalleryManager.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 16/12/23.
//

import Foundation
import Combine

//Create protocol for GalleryOperation
//We can add other operations like CRUD later
protocol GalleryOperation{
    func getGalleryList(_ searchText:String)
}

//This class is coordinator between Api and class that requires to perform CRUD operation on Gallery
class GalleryManager:GalleryOperation{
    var gallerySubject = PassthroughSubject<[Gallery], Never>()
    var cancellable = Set<AnyCancellable>()
    
    func getGalleryList(_ searchText:String){
        guard let request = Api.gallery(queryParam: "gallery/search/top/week/1?q=\(searchText)")
            .getURLRequest()
        else {
            gallerySubject.send([])
            return
        }
        
        HTTPClient.shared.getData(request: request, responseType: GalleryRootModel.self)
            .sink { value in
                switch value{
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] galleryData in
                self?.gallerySubject
                    .send(galleryData.data.arrSorted)
            }
            .store(in: &cancellable)
    }
    
}
