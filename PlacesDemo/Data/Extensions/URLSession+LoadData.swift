//
//  URLSession+LoadData.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 08.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession {
    func loadData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
