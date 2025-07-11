//
//  MemoryStorage.swift
//  TripNotes
//
//  Created by Samoo on 7/10/25.
//

import Foundation


struct MemoryStorage {
    private static let key = "stored_memories"

    // Save memories to UserDefaults
    static func save(memories: [MemoryModel]) {
        do {
            let data = try JSONEncoder().encode(memories)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("❌ Failed to save memories: \(error.localizedDescription)")
        }
    }

    // Load memories from UserDefaults
    static func load() -> [MemoryModel] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            let memories = try JSONDecoder().decode([MemoryModel].self, from: data)
            return memories
        } catch {
            print("❌ Failed to load memories: \(error.localizedDescription)")
            return []
        }
    }
}
