//
//  NetworkResponse.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

struct NetworkResponse: CustomDebugStringConvertible {
    /// Status code.
    let statusCode: Int?
    /// The response data.
    let data: Data?
    /// NetworkError that contains error retured in response.
    let error: NetworkError?
    ///
    let cashed: Bool
    
    init(statusCode: Int?, data: Data?, error: NetworkError?, cashed: Bool = false) {
        self.statusCode = statusCode
        self.data = data
        self.error = error
        self.cashed = cashed
    }
    
    /// A text description of the `NetworkResponse` that is suitable for debugging.
    var debugDescription: String {
        return "🐱\nStatus Code: \(statusCode ?? 0), Data Length: \(data?.count ?? 0), Error: \(error?.errorDescription ?? "no error")\n🐱"
    }
    
    var isSuccessful: Bool {
        return statusCode == nil ? false : 200 ... 300 ~= statusCode!
    }
    
    /// Maps data received from the signal into a String.
    func mapToString() -> String? {
        guard let data = data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Maps data received from the signal into a Decodable object.
    func map<D: Decodable>(_ type: D.Type) throws -> D? {
        guard let data = data else { return nil }
        return cashed ? try PropertyListDecoder().decode(D.self, from: data) :
                        try JSONDecoder().decode(D.self, from: data)
    }
}
