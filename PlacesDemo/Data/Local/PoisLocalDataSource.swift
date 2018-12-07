//
//  PoisLocalDataSource.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class PoisLocalDataSource: PoisDataSource {
    func pois(from page: Int, completion: @escaping (NetworkResponse) -> ()) {
        let data = UserDefaults.standard.object(forKey: String(describing: PoisResponse.self)) as? Data
        completion(NetworkResponse(statusCode: 200, data: data, error: nil, cashed: true))
    }
    
    func share(poi: PointOfInterest, completion: @escaping (NetworkResponse) -> ()) {}
}
