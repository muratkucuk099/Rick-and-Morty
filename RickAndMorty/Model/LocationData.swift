//
//  LocationData.swift
//  RickAndMorty
//
//  Created by Mac on 14.04.2023.
//

import Foundation

struct LocationData: Codable {
    let results: [Results]
}
struct Results: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}
