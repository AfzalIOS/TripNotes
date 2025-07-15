//
//  MemoryRowView.swift
//  TripNotes
//
//  Created by Samoo on 7/14/25.
//

import SwiftUI



struct MemoryRowView: View {
    let memory: MemoryModel

    var body: some View {
        HStack(spacing: 16) {
            if let uiImage = UIImage(data: memory.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(memory.title)
                    .font(.headline)

                Text(memory.note)
                    .font(.subheadline)
                    .lineLimit(1)

                Text("⭐️ Rating: \(memory.rating)/5")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

