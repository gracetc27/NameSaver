//
//  Location.swift
//  NameSaver
//
//  Created by Grace couch on 20/11/2024.
//

import MapKit
import SwiftUI

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    #if DEBUG
    static let example = Location(id: UUID(), latitude: 51.501, longitude: -0.141)
    #endif

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
