import SwiftUI
import MapKit

struct MapScreenView: View {
    @StateObject var viewModel = MemoryViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject private var searchService = LocationSearchService()

    @State private var region = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 24.8607, longitude: 67.0011),
            span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
        )
    )

    @State private var showAddMemory = false
    @State private var selectedMemory: MemoryModel? = nil

    var body: some View {
        ZStack {
            if let userLocation = locationManager.userLocation {
                Map(position: $region) {
                    // 🔴 Memory pins
                    ForEach(viewModel.memories) { memory in
                        Annotation(memory.title, coordinate: memory.coordinate.clLocationCoordinate) {
                            Button {
                                selectedMemory = memory
                            } label: {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }

                    // 🔵 Searched location pin
                    if let coord = searchService.searchedLocation {
                        Annotation("Searched", coordinate: coord) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.blue)
                                .font(.title)
                        }
                    }
                }
                .onAppear {
                    region = .region(MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    ))
                }
                .onChange(of: searchService.searchedLocation) { newLocation in
                    if let coord = newLocation {
                        region = .region(MKCoordinateRegion(
                            center: coord,
                            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                        ))
                    }
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                ProgressView("Getting your location...")
            }

            // 🔍 Search Bar UI
            VStack {
                HStack {
                    TextField("🔍 Search location", text: $searchService.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        searchService.search()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 60)

                Spacer()
            }

            // ➕ Add Memory Button
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

        // Sheet to add memory
        .sheet(isPresented: $showAddMemory) {
            let fallback = CLLocationCoordinate2D(latitude: 24.8607, longitude: 67.0011)

            AddMemoryView(
                viewModel: viewModel,
                location:
                    searchService.searchedLocation ??
                    locationManager.userLocation ??
                    fallback
            )
        }


        // Sheet to view selected memory
        .sheet(item: $selectedMemory) { memory in
            MemoryDetailView(memory: memory)
        }
    }
}

#Preview {
    MapScreenView()
}
