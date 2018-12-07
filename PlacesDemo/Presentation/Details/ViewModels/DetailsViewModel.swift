//
//  DetailsViewModel.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    // MARK: - Properties
    
    private var pointOfInterest: PointOfInterest?
    
    var locationDescription: String {
        return pointOfInterest?.location.formattedAddress.joined(separator: "\n") ?? ""
    }
    
    func setDetails(poi: PointOfInterest?) {
        self.pointOfInterest = poi
    }
    
    func getPointOfInterest() -> PointOfInterest? {
        return pointOfInterest
    }
}
