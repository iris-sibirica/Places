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
    static let clientID = "PTHSIOQBHG0LZVQR54U2KRXFL1VUMQROOU2NRZ23ULW30KNP"
    static let clientSecret = "GMQKP3PB3WPWQ3M1V3GEFXE33YTD0JLBFQKFH4BHPJ1JQB1S"
}
