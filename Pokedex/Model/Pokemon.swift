//
//  Pokemon.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import Foundation


struct PokemonResults: Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    var name: String
    var url: String
}
