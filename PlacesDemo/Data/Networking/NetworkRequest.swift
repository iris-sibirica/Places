//
//  NetworkRequest.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

enum DataType {
    case JSON
    case Data
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

/// Request is a protocol which defines the most common properties
/// related to a network request.
protocol NetworkRequestProtocol {
    
    /// The context in which the request is executed.
    /// If `nil` is returned default's `.background` queue is used.
    var context: Context? { get set }
    /// This is the path of the request (ie. `/v2/venues/explore`)
    var path: String { get set }
    /// The HTTP method used to perform the request.
    var method: HTTPMethod { get set }
    /// Parameters used to compose the fields dictionary into the url.
    var parameters: [String: String] { get }
    /// Optional headers to append to the request.
    var headers: [String: Any]? { get }
    /// This is the default cache policy used for this request.
    /// If not set related `Service` policy is used.
    var cachePolicy: CashePolicy? { get set }
    /// This is the time interval of the request.
    /// If not set related `Service` timeout is used.
    var timeout: TimeInterval? { get set }
    /// Data type: JSON or Data
    var dataType: DataType { get }
}

class NetworkRequest: NetworkRequestProtocol {
    var context: Context?
    var path: String
    var method: HTTPMethod
    var parameters: [String: String]
    var headers: [String: Any]? //Any??
    var cachePolicy: CashePolicy? = .reloadIgnoringLocalCacheData
    var timeout: TimeInterval?
    var dataType: DataType = .JSON
    
    /// Initialize a new request
    ///
    /// - Parameters:
    ///   - method: HTTP Method request (if not specified, `.get` is used)
    ///   - path: path of the request
    ///   - params: paramters to replace in endpoint
    init(method: HTTPMethod = .get, path: String, parameters: [String: String]) {
        self.method = method
        self.path = path
        self.parameters = parameters
    }
}
