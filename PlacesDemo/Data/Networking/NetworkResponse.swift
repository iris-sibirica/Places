//
//  NetworkResponse.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

struct NetworkResponse: CustomDebugStringConvertible {
    /// Status code received from signal.
    let statusCode: Int?
    /// Data received from the signal.
    let data: Data?
    /// NetworkError that contains error received from signal.
    let error: NetworkError?
    // ToDo: Think of a smart way to handle this
    /// Flag that determines whether the response is cashed or not.
    let cashed: Bool
    
    init(statusCode: Int?, data: Data?, error: NetworkError?, cashed: Bool = false) {
        self.statusCode = statusCode
        self.data = data
        self.error = error
        self.cashed = cashed
    }
    
    /// A text description of the `NetworkResponse` that is suitable for debugging.
    var debugDescription: String {
        return "🐱\nStatus Code: \(statusCode ??? "unknown"), Data Length: \(data?.count ??? "unknown"), Error: \(error?.errorDescription ?? "unknown")\n🐱"
    }
    
    /// A Boolean value that determines whether the response is successful or not.
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
