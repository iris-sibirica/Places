//
//  Constants.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

struct API {
    struct BaseUrl {
        static let Scheme = "https"
        static let Host = "api.foursquare.com"
        static let ExplorePath = "/v2/venues/explore"
        
    }
    struct Path {
        static let QueryParameters = ["ll": "\(CurrentLocation.Latitude)" + "," + "\(CurrentLocation.Longitude)",
                            "v": "20170607",
                            "intent": "checkin",
                            "radius": "4000",
                            "client_id": clientID,
                            "client_secret": clientSecret]
    }
    struct CurrentLocation {
        static let Latitude = 52.500342
        static let Longitude = 13.425170
    }
    static let clientID = "YOUR_CLIENT_ID"
    static let clientSecret = "YOUR_CLIENT_SECRET"
}
