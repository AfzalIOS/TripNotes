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
    let id: UUID
    let title: String
    let date: Date
    let coordinate: CoordinateCodable
    let note: String
    let imageData: Data
    let rating: Int
    
    
}

