//
//  PoisResponse.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 06.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

struct PoisResponse: Codable {
    let pois: [PointOfInterest]
    let hasMore: Bool
    let page: Int
}
