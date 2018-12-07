//
//  Dispatcher.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

/// This is a protocol responsible to execute a NetworkRequest
/// by calling the underlyning layer (URLSession or just a fake
/// dispatcher which returns mocked results).
protocol ServiceProtocol {
    
    /// This is the environment used by the service.
    var environment: Environment { get }
    /// Initialize a new service with specified environment.
    init(environment: Environment)
    /// Execute a NetworkRequest and return a NetworkResponse.
    ///
    /// - Parameter request: request to execute
    /// - Completion: NetworkResponse
    func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> ())
}

/// Implementaion of ServiceProtocol
class Service: ServiceProtocol {
    
    internal var environment: Environment
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = environment.cachePolicy
        configuration.urlCache = nil
        return URLSession.init(configuration: configuration)
    }
    
    /// Initialize a new service with given environment
    ///
    /// - Parameter environment: environment
    required public init(environment: Environment) {
        self.environment = environment
    }
    
    /// Execute a `NetworkRequest` and return a completion block with a`NetworkResponse`
    ///
    /// - Parameters:
    ///   - request: NetworkRequest to execute
    ///
    func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> ()) {
        guard let urlRequest = prepareUrlRequest(from: request) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //print(self.debugHTTPURLResponse(response as? HTTPURLResponse))
            let networkResponse = NetworkResponse(statusCode: (response as? HTTPURLResponse)?.statusCode,
                                                  data: data,
                                                  error: NetworkError.underlying(error))
            //print(networkResponse.debugDescription)
            completion(networkResponse)
        }.resume()
    }
}

// MARK: - Private Methods

extension Service {
    private func prepareUrlRequest(from request: NetworkRequest) -> URLRequest? {
        //URL components
        let urlParameters_1 = request.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        let urlParameters_2 = API.Path.QueryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents()
        urlComponents.queryItems = urlParameters_2 + urlParameters_1
        urlComponents.scheme = environment.scheme.rawValue
        urlComponents.host = environment.host
        urlComponents.path = request.path
        //URLRequest
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        let body = try? JSONEncoder().encode(request.parameters)
        urlRequest.httpBody = body
        urlRequest.httpMethod = request.method.rawValue
        //environment.headers.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        //request.headers?.forEach { urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        return urlRequest
    }
    
    private func debugHTTPURLResponse(_ response: HTTPURLResponse?) -> String {
        guard let response = response else { return "🐱 HTTPURLResponse is nil! 🐱" }
        let statusCode = response.statusCode
        let headers = response.allHeaderFields as! [String: String]
        return "🐱 \nStatus code: \(statusCode). \nHeaders: \(headers) \n🐱"
    }
}
