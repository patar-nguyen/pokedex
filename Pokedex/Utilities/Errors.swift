//
//  Errors.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import Foundation

enum Errors: String, Error {
    case invalidURL = "Invalid URL"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data receieved from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "This user is already in favorites"
    case unableToDecode = "Unable to decode"
}
