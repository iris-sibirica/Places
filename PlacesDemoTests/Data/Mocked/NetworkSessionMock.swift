//
//  URLSessionMock.swift
//  PlacesDemoTests
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation
@testable import PlacesDemo

class NetworkSessionMock: NetworkSession {
    private (set) var lastURL: URL?
    let data: Data?
    let urlResponse: URLResponse?
    let error: Error?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }
    
    func loadData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        lastURL = request.url
        completion(data, urlResponse, error)
    }
}
