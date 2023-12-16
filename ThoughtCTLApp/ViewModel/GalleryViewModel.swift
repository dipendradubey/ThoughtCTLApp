//
//  GalleryViewModel.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 15/12/23.
//

import Foundation
import Combine

class GalleryViewModel:ObservableObject{
    @Published var isListSelected = true
    @Published var textFieldText = ""
    var cancellable = Set<AnyCancellable>()
    @Published var arrGallery = [Gallery]()
    var searchTextSubject = PassthroughSubject<String, Never>()
    let galleryManager = GalleryManager()
    //observe the value changes in textfield and make api call when user stop typing
    func publisherSetUp(){
        searchTextSubject
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchText(searchText)
            }.store(in: &cancellable)
        galleryManager.gallerySubject
            .receive(on: RunLoop.main)
            .assign(to: &$arrGallery)
    }
    
    func searchText(_ searchText:String){
        if searchText.isStringEmpty{
            clearArrGallery()
            return
        }
        galleryManager.getGalleryList(searchText)
    }
    
    func clearArrGallery(){
        arrGallery = []
    }
}
