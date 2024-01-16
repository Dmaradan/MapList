//
//  Location.swift
//  MapList
//
//  Created by Diego Martin on 1/16/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
}
