//
//  GalleryViewModel.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation
import Combine

class GalleryViewModel:ObservableObject{
    @Published var selectedOption = "List"
    @Published var textFieldText = ""
    var cancellable = Set<AnyCancellable>()
    @Published var arrGallery = [Gallery]()
    let currentTextPublisher = CurrentValueSubject<String, Never>("")
    
    //observe the value changes in textfield and make api call when user stop typing
    func publisherSetUp(){
        currentTextPublisher
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchText(searchText)
            }.store(in: &cancellable)
    }
    
    func searchText(_ searchText:String){
        if searchText.isStringEmpty{return}
        guard let request = Api.gallery(queryParam: "gallery/search/top/week/1?q=\(searchText)")
            .getURLRequest()
        else {return}
        
        HTTPClient.shared.getData(request: request, responseType: GalleryRootModel.self)
            .receive(on: RunLoop.main)
            .sink { value in
                switch value{
                case .finished:
                    print("Received value")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] galleryData in
                self?.arrGallery = galleryData.data.arrSorted
                //debugPrint(self?.arrGallery[0])
            }
            .store(in: &cancellable)
    }
}
