//
//  MapView.swift
//  NewDigs
//
//  Created by Arthur Roolfs on 11/1/22.
//

import SwiftUI
import MapKit

struct Pin: Identifiable {
    var id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @State private var coord: CLLocationCoordinate2D
    let dist = 1000.0

    private var region: Binding<MKCoordinateRegion> {
        Binding {
            return MKCoordinateRegion(center: coord, span: MKCoordinateRegion(center: coord, latitudinalMeters: dist, longitudinalMeters: dist).span)
        } set: { _ in }
    }

    init(coord: CLLocationCoordinate2D) {
        self.coord = coord
    }

    var body: some View {
        let pins = [
            Pin(coordinate: coord)
        ]
        Map(coordinateRegion: region, annotationItems: pins) {
            MapPin(coordinate: $0.coordinate)
        }
    }
}
