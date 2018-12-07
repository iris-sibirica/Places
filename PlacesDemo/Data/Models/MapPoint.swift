//
//  MapPoint.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation
import MapKit

class MapPoint: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let category: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.category = category
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
