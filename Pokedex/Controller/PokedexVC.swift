//
//  PokedexVC.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import UIKit

class PokedexVC: UIViewController {

    var tableView = UITableView()
    var pokemonList: [PokemonEntry] = []
    
    var trainerName: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemon()
        //getSprites()
        configureViewController()
        configureTableView()
        
    }
    
    init(trainerName: String) {
        self.trainerName = trainerName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "\(trainerName)'s Pokedex"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuseID)
    }
    
    func getPokemon() {
        NetworkManager.shared.getPokemon() {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemon):
                self.pokemonList = pokemon
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
//    func getSprites() {
//        NetworkManager.shared.getSprites(url: "https://pokeapi.co/api/v2/pokemon/1/") {[weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let sprite):
//                print(sprite)
//            case .failure(let error):
//                print(error.rawValue)
//            }
//        }
//    }
}

extension PokedexVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseID) as! PokemonCell
        let pokemon = pokemonList[indexPath.row]
        cell.set(pokemon: pokemon)
        return cell
    }
    
    
}
