//
//  MemoryModel.swift
//  TripNotes
//
//  Created by Samoo on 7/10/25.
//

import Foundation
import CoreLocation
import SwiftUI

struct MemoryModel: Identifiable, Codable {
    var id: UUID
    var title: String
    var date: Date
    var coordinate: CoordinateCodable
    var note: String
    var imageData: Data
    var rating: Int
}




