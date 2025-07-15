//
//  MemoryDetailView.swift
//  TripNotes
//
//  Created by Samoo on 7/14/25.
//

import SwiftUI

import SwiftUI
import MapKit

struct MemoryDetailView: View {
    let memory: MemoryModel

    @State private var region: MKCoordinateRegion

    init(memory: MemoryModel) {
        self.memory = memory
        self._region = State(initialValue: MKCoordinateRegion(
            center: memory.coordinate.clLocationCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                if let uiImage = UIImage(data: memory.imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(12)
                }

                Text(memory.title)
                    .font(.title)
                    .bold()

                Text("🗓️ \(formattedDate(memory.date))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("📝 \(memory.note)")
                    .font(.body)

                HStack {
                    Text("⭐️ Rating: \(memory.rating)/5")
                    Spacer()
                    Text("📍 Location")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                if #available(iOS 17.0, *) {
                    Map(initialPosition: .region(region)) {
                        Marker(memory.title, coordinate: memory.coordinate.clLocationCoordinate)
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("Map not supported on this iOS version.")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    MemoryDetailView(memory: DummyMemoryData.sampleMemories[0])
}

