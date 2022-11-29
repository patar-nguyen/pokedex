//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
        
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    private let url = "https://pokeapi.co/api/v2/pokemon?limit=151"

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
    
    
    func getPokemonInfo(for name: String, completion: @escaping (Result<PokemonInfo, Errors>) -> Void) {
        let endpoint = baseURL + "\(name)"
        guard let url = URL(string: endpoint) else {
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
                let pokemonResults = try self.decoder.decode(PokemonInfo.self, from: data)
                completion(.success(pokemonResults))
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

    func loadImage(url: String, completion: @escaping(Result<UIImage, Errors>) -> Void) {
        //on main thread
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        //on background thread - data task
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(image))
        }
        dataTask.resume()
    }
    
    func loadSpecificImage(url: String, completion: @escaping(Result<UIImage, Errors>) -> Void) {
        //on main thread
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        //on background thread - data task
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(image))
        }
        dataTask.resume()
    }
}

extension Data {
    func parseData(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        
        return data
    }
}
