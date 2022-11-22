//
//  PokemonSprite.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-22.
//

import Foundation

struct PokemonSelected: Codable {
    var sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    var front_default: String
}
