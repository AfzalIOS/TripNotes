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
    
    func addMemory(_ memory: MemoryModel) {
           memories.append(memory)
           saveMemories()
       }
    
    func saveMemories() {
            MemoryStorage.save(memories: memories)
        }

        // Load memories from storage
        func loadMemories() {
            memories = MemoryStorage.load()
        }
}
