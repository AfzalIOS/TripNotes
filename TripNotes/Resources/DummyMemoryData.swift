//
//  DummyMemoryData.swift
//  TripNotes
//
//  Created by Samoo on 7/14/25.
//

import Foundation
import UIKit
import CoreLocation

struct DummyMemoryData {
    static let sampleMemories: [MemoryModel] = [
        MemoryModel(
            id: UUID(),
            title: "Trip to Murree",
            date: Date(),  // 👈 date 3rd argument
            coordinate: CoordinateCodable(from: CLLocationCoordinate2D(latitude: 33.9076, longitude: 73.3904)),
            note: "Snowfall was amazing!", // 👈 note 5th
            imageData: placeholderImageData,
            rating: 4
        )

    ]

    /// Placeholder image for demo data
    static var placeholderImageData: Data {
        UIImage(named: "placeholder")?.jpegData(compressionQuality: 0.8) ?? Data()
    }
}
