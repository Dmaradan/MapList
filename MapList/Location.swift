//
//  Location.swift
//  MapList
//
//  Created by Diego Martin on 1/16/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Herpingham Palace", description: "Lit by 1 lightbulb", latitude: 51.501, longitude: -0.141)
    #endif
}
