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
    
    func pois(offset: Int, completion: @escaping (NetworkResponse) -> ()) {
        remoteDataSource.pois(offset: offset, completion: completion)
    }
}
