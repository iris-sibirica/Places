//
//  PoisRemoteDataSource.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import  Foundation

class PoisRemoteDataSource: PoisDataSource {
    private var service: Service

    init(service: Service) {
        self.service = service
    }

    func pois(from page: Int, completion: @escaping (NetworkResponse) -> ()) {
        let request = NetworkRequest(method: .get, path: API.BaseUrl.ExplorePath, parameters: ["page": "\(page)"]) //FIX
        service.execute(request: request, completion: { result in
            completion(result)
        })
    }
}
