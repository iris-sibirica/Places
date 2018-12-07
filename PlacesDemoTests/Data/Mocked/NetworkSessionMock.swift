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
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func loadData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, response, error)
    }
}
