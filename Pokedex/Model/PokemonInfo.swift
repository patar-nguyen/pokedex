//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-22.
//

import Foundation

struct PokemonInfo: Codable {
    var name: String
    var sprites: PokemonImage
    var id: Int
    var base_experience: Int
    var height: Int
    var weight: Int
}

struct PokemonImage: Codable {
    var front_default: String
}
