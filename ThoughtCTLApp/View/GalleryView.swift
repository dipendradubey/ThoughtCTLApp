//
//  ContentView.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 13/12/23.
//

import SwiftUI


struct GalleryView: View {
    @StateObject var galleryViewModel = GalleryViewModel()
    @State var searchText = ""
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                TextField(text: $searchText) {
                    Text("Search")
                        .foregroundColor(.gray)
                }
                .textFieldStyle(.roundedBorder)
                //This support ios 17+ as older api is deprecated
                .onChange(of: searchText, initial: false) { oldValue, newValue in
                    galleryViewModel.searchTextSubject.send(newValue)
                }
                
                if galleryViewModel.isListSelected{
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
        .navigationBarItems(
            leading: Button(action: {
                withAnimation(.easeInOut){
                    galleryViewModel.isListSelected.toggle()
                }
            }) {
                Text("Switch Animation")
                    .font(.headline)
                    .foregroundColor(.white)
            },
            trailing:
                Text(galleryViewModel.isListSelected ? "Grid" : "List")
                .font(.subheadline)
                .foregroundColor(.white)
        )
    }
}

// MARK: - ListView
struct ListView:View {
    @ObservedObject var viewModel:GalleryViewModel
    var body: some View {
        ForEach(viewModel.arrGallery){ gallery in
            ListCell(viewModel: viewModel, gallery: gallery)
        }
    }
}

struct ListCell:View {
    @ObservedObject var viewModel:GalleryViewModel
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
            
            ThumbNail(gallery: gallery)
            
            VStack(alignment: .leading, spacing: 12)
            {
                TitleView(viewModel: viewModel,gallery: gallery)
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
                GridCell(viewModel: viewModel, gallery: gallery)
            }
        }
        .padding()
    }
}

struct GridCell: View {
    @ObservedObject var viewModel:GalleryViewModel
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
            ThumbNail(gallery: gallery)
            TitleView(viewModel: viewModel, gallery: gallery)
        }
    }
}

struct ThumbNail:View{
    let gallery: Gallery
    var url:URL?{
        guard let arrImages = gallery.images, !arrImages.isEmpty, let link = arrImages[0].link
        else{return nil}
        return URL(string: link)
    }
    var body: some View{
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
    }
}

struct TitleView:View {
    @ObservedObject var viewModel:GalleryViewModel
    let gallery: Gallery
    var timeStamp:String{
        DateHelper.formatDate(timestamp: gallery.dateTime)
    }
    var noOfLine:Int{
        viewModel.isListSelected ? 2 : 1
    }
    var body: some View {
        Text(gallery.title)
            .font(.headline)
            .lineLimit(noOfLine)
            .frame(maxWidth: viewModel.isListSelected ? /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ : nil,
                   alignment:viewModel.isListSelected ? .leading : .center)
        Text(timeStamp)
            .font(.subheadline)
            .foregroundColor(.secondary)
        if let imageCount = gallery.imageCount{
            Text("\(imageCount) image(s)")
                .font(.subheadline)
        }
    }
}

#Preview {
    GalleryView()
}
