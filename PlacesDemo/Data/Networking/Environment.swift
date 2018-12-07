//
//  Environment.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

enum Scheme: String {
    case HTTP
    case HTTPS
}

/// This is a struct which is used to configure network connection
/// with a backend server
final class Environment {
    
    /// Name of the server configuration (ie. "Testing" or "Production")
    private(set) var name: String
    /// This is the scheme
    private(set) var scheme: Scheme
    /// This is the host
    private(set) var host: String
    /// These are the global headers
    private(set) var headers: [String: Any]
    /// Cache policy you want apply to each request done with this service
    private(set) var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    /// Global timeout for any request (it can be overriden in Request)
    public var timeout: TimeInterval = 15.0
    
    /// Initialize new environment
    ///
    /// - Parameters:
    ///   - name: name of the environment (just for debug purpose)
    ///   - scheme: base url of the environment
    ///   - host:
    ///   - headers: 
    init(name: String? = nil, scheme: Scheme = .HTTPS, host: String, headers: [String: Any] = [:]) {
        self.scheme = scheme
        self.host = host
        self.headers = headers
        self.name = name ?? host
    }
}
