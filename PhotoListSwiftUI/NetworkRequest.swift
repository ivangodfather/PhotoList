//
//  NetworkRequest.swift
//  PhotoListSwiftUI
//
//  Created by Ivan Ruiz Monjo on 17/03/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import Combine

class NetworkRequest<A>: ObservableObject {
    
    var result: Result<A, Error>? {
        didSet {
            subject.send()
        }
    }
    
    var objectWillChange: AnyPublisher<(), Never> = Empty().eraseToAnyPublisher()
    let subject = PassthroughSubject<(), Never>()
    
    var value: A? {
        try? result?.get()
    }
    
    private let transform: (Data) -> A?
    private let url: URL
    
    init(url: URL, transform: @escaping (Data) -> A?) {
        self.transform = transform
        self.url = url
        objectWillChange = subject.handleEvents(receiveSubscription: { sub  in
            self.fetch()
        }).eraseToAnyPublisher()
    }
    
    private func fetch() {
        URLSession.shared
            .dataTask(with: url) { data, _, _ in
                guard
                    let data = data,
                    let value = self.transform(data) else {
                        DispatchQueue.main.async {
                            self.result = Result.failure(NSError())
                        }
                        return
                }
                
                DispatchQueue.main.async {
                    self.result = Result.success(value)
                }
        }.resume()
    }
}

extension NetworkRequest where A: Decodable {
    convenience init(url: URL) {
        self.init(url: url, transform: { try? JSONDecoder().decode(A.self, from: $0) })
    }
}
