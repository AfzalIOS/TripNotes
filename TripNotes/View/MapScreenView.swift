//
//  MapScreenView.swift
//  TripNotes
//
//  Created by Samoo on 7/11/25.
//

import SwiftUI
import MapKit

struct MapScreenView: View {
    @StateObject var viewModel = MemoryViewModel()
    @StateObject var locationManager = LocationManager()
    
    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 24.8607, longitude: 67.0011),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    )
    
    @State private var showAddMemory = false
    @State private var selectedMemory: MemoryModel? = nil
    
    var body: some View {
        ZStack {
            if let userLocation = locationManager.userLocation {
                Map(position: $region) {
                    ForEach(viewModel.memories) { memory in
                        Annotation(memory.title, coordinate: memory.coordinate.clLocationCoordinate) {
                            Button(action: {
                                selectedMemory = memory
                            }) {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                }
                .onAppear {
                    region = .region(MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    ))
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                ProgressView("Getting your location...")
            }

            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAddMemory = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
        }
        // Sheet for adding new memory
//        .sheet(isPresented: $showAddMemory) {
//            AddMemoryView(viewModel: viewModel, location: locationManager.userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))
//        }

        // Sheet for viewing selected memory
//        .sheet(item: $selectedMemory) { memory in
//            MemoryDetailView(memory: memory)
//        }
    }
}

#Preview {
    MapScreenView()
}
