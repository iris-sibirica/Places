//
//  Dispatcher.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class Service: ServiceProtocol {
    
    var environment: Environment
    var session: NetworkSession
    
    required public init(environment: Environment, session: NetworkSession = URLSession.shared) {
        self.environment = environment
        self.session = session
    }
    
    func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> ()) {
        guard let urlRequest = prepareURLRequest(from: request) else { return }
        
        session.loadData(request: urlRequest, completion: { (data, response, error) in
            print(self.debugHTTPURLResponse(response as? HTTPURLResponse))
            
            let networkResponse = NetworkResponse(statusCode: (response as? HTTPURLResponse)?.statusCode, data: data, error: NetworkError.underlying(error))
            print(networkResponse.debugDescription)
            completion(networkResponse)
        })
    }
}

// MARK: - Private Methods

extension Service {
    private func prepareURLRequest(from request: NetworkRequest) -> URLRequest? {
        //URL components
        var urlComponents = URLComponents()
        urlComponents.scheme = environment.scheme.rawValue
        urlComponents.host = environment.host
        urlComponents.path = request.path
        var queryItems = API.Path.QueryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        queryItems.append(contentsOf: request.parameters.map { URLQueryItem(name: $0.key, value: $0.value) })
        urlComponents.queryItems = queryItems
        
        //URLRequest
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }
    
    private func debugHTTPURLResponse(_ response: HTTPURLResponse?) -> String {
        guard let response = response else { return "🐱 HTTPURLResponse is nil! 🐱" }
        let statusCode = response.statusCode
        let headers = response.allHeaderFields as? [String: String]
        return "🐱 \nStatus code: \(statusCode). \nHeaders: \(headers ?? [:]) \n🐱"
    }
}
