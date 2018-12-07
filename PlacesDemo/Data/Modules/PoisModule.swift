//
//  PoisModule.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class PoisModule {
    static let shared = PoisModule()
    
    func poisRemoteDataSource(service: Service) -> PoisDataSource {
        return PoisRemoteDataSource(service: service)
    }
    
    func poisLocalDataSource() -> PoisDataSource {
        return PoisLocalDataSource()
    }
}
