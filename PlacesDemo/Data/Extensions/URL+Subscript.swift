//
//  URL+Subscript.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 10.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

extension URL {
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        if let parameters = url.queryItems {
            return parameters.first(where: { $0.name == queryParam })?.value
        } else if let paramPairs = url.fragment?.components(separatedBy: "?").last?.components(separatedBy: "&") {
            for pair in paramPairs where pair.contains(queryParam) {
                return pair.components(separatedBy: "=").last
            }
            return nil
        } else {
            return nil
        }
    }
}
