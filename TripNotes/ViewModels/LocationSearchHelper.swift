//
//  LocationSearchService.swift
//  TripNotes
//
//  Created by Samoo on 7/14/25.
//



import Foundation
import MapKit

class LocationSearchService: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchedLocation: CLLocationCoordinate2D? = nil

    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                DispatchQueue.main.async {
                    self.searchedLocation = coordinate
                }
            }
        }
    }
}

