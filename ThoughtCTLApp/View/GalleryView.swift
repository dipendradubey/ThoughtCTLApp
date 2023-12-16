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
        ScrollView {
            VStack (alignment: .leading) {
                TextField(text: $searchText) {
                    Text("Search")
                        .foregroundColor(.gray)
                }
                .textFieldStyle(.roundedBorder)
                //This support ios 17+
                .onChange(of: searchText, initial: false) { oldValue, newValue in
                    galleryViewModel.searchText(newValue)
                }
                
                if isListSelected{
                    ListView(viewModel: galleryViewModel)
                }else{
                    GridView(viewModel: galleryViewModel)
                }
            }
            
        }
        .padding()
        .onAppear{
            galleryViewModel.publisherSetUp()
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
    }
}

// MARK: - ListView
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
                            .fill(Color(red: 234/255.0, green: 234/255.0, blue: 234/255.0))
                            .frame(width: 110, height: 110)
                            .cornerRadius(10)
                    )
                
            } placeholder: {
                Rectangle()
                    .fill(Color(red: 234/255.0, green: 234/255.0, blue: 234/255.0))
                    .frame(width: 110, height: 110)
            }
            .frame(width: 110, height: 110)
            
            VStack(alignment: .leading, spacing: 12)
            {
                Text(gallery.title)
                    .font(.headline)
                    .lineLimit(2)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment:.leading)
                Text(timeStamp)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let imageCount = gallery.imageCount{
                    Text("\(imageCount) image(s)")
                        .font(.subheadline)
                }
            }
        }
    }
}


// MARK: - GridView

struct GridView:View {
    @ObservedObject var viewModel:GalleryViewModel
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 16)
        ], spacing: 16) {
            ForEach(viewModel.arrGallery){ gallery in
                GridCell(gallery: gallery)
            }
        }
        .padding()
    }
}

struct GridCell: View {
    let gallery: Gallery
    var timeStamp:String{
        DateHelper.formatDate(timestamp: gallery.dateTime)
    }
    var url:URL?{
        guard let arrImages = gallery.images,
                !arrImages.isEmpty,
              let link = arrImages[0].link
        else{return nil}
        return URL(string: link)
    }
    
    var body: some View {
        VStack {
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
            
            Text(gallery.title)
                .lineLimit(1)
            
            Text(timeStamp)
            
            if let imageCount = gallery.imageCount{
                Text("\(imageCount) image(s)")
            }
        }
    }
}


#Preview {
    GalleryView()
}
