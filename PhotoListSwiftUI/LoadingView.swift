//
//  LoadingView.swift
//  PhotoListSwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView<Content, Placeholder, A>: View where Content: View, Placeholder: View {
    
    var placeholder: Placeholder
    @ObservedObject var networkRequest: NetworkRequest<A>
    var content: (A) -> Content

    
    var body: some View {
        Group {
            if networkRequest.value != nil {
                content(networkRequest.value!)
            } else {
                placeholder
            }
        }
    }
}
