//
//  PoisDataSource.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

protocol PoisDataSource {
    func pois(offset: Int, completion: @escaping (NetworkResponse) -> ())
}
