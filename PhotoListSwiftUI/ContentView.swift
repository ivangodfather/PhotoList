//
//  ContentView.swift
//  PhotoListSwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

let photosURL = URL(string: "https://picsum.photos/v2/list")!

struct Photo: Decodable, Identifiable {
    let id, author: String
    let download_url: URL
    let width, height: Int
    
}

struct ContentView: View {
    
    @ObservedObject var networkRequest: NetworkRequest<[Photo]>
    
    init() {
        self.networkRequest = NetworkRequest(url: photosURL)
    }
    
    var body: some View {
        LoadingView(
            placeholder: ActivityIndicator(isLoading: .constant(true), style: .medium),
                    networkRequest: networkRequest) { photos in
             PhotoListView(photos: photos)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
