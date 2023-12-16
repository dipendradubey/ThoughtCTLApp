//
//  ContentView.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 13/12/23.
//

import SwiftUI

//This will work for ios17 and later as onchangeof method is deprecated

struct GalleryView: View {
    @StateObject var galleryViewModel = GalleryViewModel()
    @State var searchText = ""
    var isListSelected:Bool{
        galleryViewModel.selectedOption == "List"
    }
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack (alignment: .leading) {
                    TextField(text: $searchText) {
                        Text("Search")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    
                    if isListSelected{
                        ListView(viewModel: galleryViewModel)
                    }
                }
                /*.searchable(text: $searchText)
                .onChange(of: searchText, initial: false, { _, newValue in
                    galleryViewModel.searchText(newValue)
                })
                */
                 
            }
            .padding()
            .onAppear{
                galleryViewModel.publisherSetUp()
                DispatchQueue.main.asyncAfter(deadline: .now()+2){
                    galleryViewModel.searchText("Cat")
                }
        }
            .navigationBarTitle("Gallery", displayMode: .inline)
                        .navigationBarItems(
                            leading: Text("Switch")
                                .foregroundColor(.white),
                            trailing: Button(action: {
                                galleryViewModel.selectedOption = isListSelected ? "Grid" : "List"
                            }) {
                                Text(isListSelected ? "Grid" : "List")
                                    .foregroundColor(.white)
                            }
                        )
                        //.ignoresSafeArea(.top)
        }
        
    }
}

struct ListView:View {
    @ObservedObject var viewModel:GalleryViewModel
    var body: some View {
        ForEach(viewModel.arrGallery){ gallery in
            ListCell(gallery: gallery)
        }
    }
}

struct ListCell:View {
    let gallery: Gallery
    var timeStamp:String{
        DateHelper.formatDate(timestamp: gallery.dateTime)
    }
    var url:URL?{
        guard let arrImages = gallery.images, !arrImages.isEmpty, let link = arrImages[0].link
        else{return nil}
        return URL(string: link)
    }
    
    var body: some View {
        
        HStack (alignment: .top,spacing: 10){
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height: 100)
                    .background(
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 110, height: 110)
                            .cornerRadius(10)
                    )
                    
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 110, height: 110)
            }
            
            VStack(alignment: .leading)
            {
                Text(gallery.title)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                Text(timeStamp)
                if let imageCount = gallery.imageCount{
                    Text("\(imageCount) image(s)")
                }
            }
            .background(Color.green)
        }
        .frame(maxWidth:.infinity)
    }
}


#Preview {
    GalleryView()
}
