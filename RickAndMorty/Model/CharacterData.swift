//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Mac on 15.04.2023.
//

import Foundation

struct CharacterData: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
    let created: String
    let location: Location
    
}
struct Origin: Decodable {
    let name: String
}
struct Location: Decodable {
    let name: String
}
