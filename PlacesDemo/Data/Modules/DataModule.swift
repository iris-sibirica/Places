//
//  DataModule.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class DataModule {
    static let shared = DataModule()
    private let service = Service(environment: Environment(host: API.BaseUrl.Host))
    
    func poisRepository() -> PoisDataSource {
        let poisRemoteDataSource = PoisModule.shared.poisRemoteDataSource(service: service)
        let poisLocalDataSource = PoisModule.shared.poisLocalDataSource()
        return PoisRepository(remoteDataSource: poisRemoteDataSource, localDataSource: poisLocalDataSource)
    }
}
