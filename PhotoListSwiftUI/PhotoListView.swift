//
//  PhotoListView.swift
//  PhotoListSwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct PhotoListView: View {
    
    var photos: [Photo]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photos) { photo in
                    NavigationLink(destination: PhotoDetailView(photo: photo)) {
                        Text(photo.author)
                    }
                }
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(photos: [Photo(id: "123", author: "Author", download_url: photosURL, width: 10, height: 10)])
    }
}
