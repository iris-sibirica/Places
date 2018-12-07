//
//  PointOfInterest.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

struct PointOfInterest: Codable {
    let id: String
    let name: String
    let location: Location
    let categoryName: String
}

struct Root: Codable {
    let meta: Meta
    let response: Response
}

struct Meta: Codable {
    let code: Int
    let requestID: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

struct Response: Codable {
    let warning: Warning?
    let suggestedRadius: Int?
    let headerLocation, headerFullLocation, headerLocationGranularity: String?
    let totalResults: Int?
    let suggestedBounds: SuggestedBounds?
    let groups: [Group]?
}

struct Group: Codable {
    let type, name: String
    let items: [GroupItem]
}

struct GroupItem: Codable {
    let reasons: Reasons
    let venue: Venue
}

struct Reasons: Codable {
    let count: Int
    let items: [ReasonsItem]
}

struct ReasonsItem: Codable {
    let summary, type, reasonName: String
}

struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let venuePage: VenuePage?
}

struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

struct Icon: Codable {
    let iconPrefix: String
    let suffix: String
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

struct Location: Codable {
    let address: String
    let crossStreet: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode, cc, city, state: String
    let country: String
    let formattedAddress: [String]
}

struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}

struct VenuePage: Codable {
    let id: String
}

struct SuggestedBounds: Codable {
    let ne, sw: Ne
}

struct Ne: Codable {
    let lat, lng: Double
}

struct Warning: Codable {
    let text: String
}
