//
//  ServiceProtocol.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 08.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

/// This is a protocol responsible to execute a NetworkRequest
/// by calling the underlyning layer (URLSession or just a fake
/// dispatcher which returns mocked results).
protocol ServiceProtocol {
    
    var environment: Environment { get }
    var session: NetworkSession { get }
    init(environment: Environment, session: NetworkSession)
    func execute(request: NetworkRequest, completion: @escaping (NetworkResponse) -> ())
}
