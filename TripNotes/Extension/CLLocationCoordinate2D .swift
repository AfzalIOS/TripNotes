//
//  CLLocationCoordinate2D .swift
//  TripNotes
//
//  Created by Samoo on 7/14/25.
//

import Foundation
import CoreLocation

// ✅ Now SwiftUI can track changes in location values
extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

