//
//  NetworkSessionProtocol.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func loadData(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
