//
//  PoisRepository.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class PoisRepository: PoisDataSource {
    private var remoteDataSource: PoisDataSource
    private var localDataSource: PoisDataSource
    
    init(remoteDataSource: PoisDataSource, localDataSource: PoisDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func pois(from page: Int, completion: @escaping (NetworkResponse) -> ()) {
        localDataSource.pois(from: 0, completion: { response in
            if response.data == nil {
                 self.remoteDataSource.pois(from: page, completion: completion)
            } else {
                //print(response.debugDescription)
                completion(response)
            }
        })
    }
}
