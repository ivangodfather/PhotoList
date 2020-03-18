//
//  PhotoView.swift
//  PhotoListSwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct PhotoDetailView: View {
    
    var photo: Photo
    var networkRequest: NetworkRequest<UIImage>
    
    init(photo: Photo) {
        self.photo = photo
        self.networkRequest = NetworkRequest(url: photo.download_url, transform: { UIImage(data: $0) })
    }
    
    var body: some View {
        LoadingView(
            placeholder: ActivityIndicator(isLoading: .constant(true), style: .large),
            networkRequest: networkRequest) {  image in
                PhotoDetailContentView(image: image)
        }
        
    }
}

struct PhotoDetailContentView: View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct PhotoDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailContentView(image: UIImage.init(systemName: "info")!)
    }
}
