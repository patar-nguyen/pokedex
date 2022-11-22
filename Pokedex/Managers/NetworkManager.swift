//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()

    private let url = "https://pokeapi.co/api/v2/pokemon?limit=151"
    let decoder = JSONDecoder()
    
    func getPokemon(completion: @escaping (Result<[PokemonEntry], Errors>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let pokemonResults = try self.decoder.decode(PokemonResults.self, from: data)
                let pokemonList = pokemonResults.results
                completion(.success(pokemonList))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getSprites(url: String, completion: @escaping (Result<PokemonSprites, Errors>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let pokemonSprites = try self.decoder.decode(PokemonSelected.self, from: data)
                let pokemonImage = pokemonSprites.sprites
                
                completion(.success(pokemonImage))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
