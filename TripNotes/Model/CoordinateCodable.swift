//
//  CoordinateCodable.swift
//  TripNotes
//
//  Created by Samoo on 7/10/25.
//

import Foundation
import CoreLocation

struct CoordinateCodable: Codable {
    
    
    let latitude: Double
    let longitude: Double
    
    var clLocationCoordinate: CLLocationCoordinate2D{
        
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
    
    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    
}
