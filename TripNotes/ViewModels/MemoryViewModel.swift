//
//  MemoryViewModel.swift
//  TripNotes
//
//  Created by Samoo on 7/10/25.
//

import Foundation
import CoreLocation
import SwiftUI

class MemoryViewModel: ObservableObject {
    
    @Published var memories: [MemoryModel] = []
    
    
    init(){
        
    }
    
    func addMemory(title: String, date: Date, note: String, image: UIImage, location: CLLocationCoordinate2D, rating: Int ){
        
        let newMemory = MemoryModel(
                   id: UUID(),
                   title: title,
                   date: date,
                   coordinate: CoordinateCodable(from: location),
                   note: note,
                   imageData: image.jpegData(compressionQuality: 0.8) ?? Data(),
                   rating: rating
                   
                   )
        memories.append(newMemory)
        
        
        
    }
    
    func saveMemories() {
            MemoryStorage.save(memories: memories)
        }

        // Load memories from storage
        func loadMemories() {
            memories = MemoryStorage.load()
        }
}
