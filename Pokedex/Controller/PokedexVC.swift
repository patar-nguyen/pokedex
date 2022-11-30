//
//  PokedexVC.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import UIKit

class PokedexVC: UIViewController {

    var tableView = UITableView()
    var pokemon: [PokemonEntry] = []
    var filteredPokemon: [PokemonEntry] = []
    var trainerName: String
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemon()
        configureViewController()
        configureSearchController()
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
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        //searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a Pokemon"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
        NetworkManager.shared.getPokemon() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.filteredPokemon = pokemon
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

extension PokedexVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseID) as! PokemonCell
        let pokemon = filteredPokemon[indexPath.row]
        cell.set(pokemon: pokemon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = filteredPokemon[indexPath.row].name
        let destination = PokemonInfoVC(name: name)
        let navController = UINavigationController(rootViewController: destination)
        present(navController, animated: true)
    }
}

extension PokedexVC: UISearchResultsUpdating/*, UISearchBarDelegate*/ {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredPokemon.removeAll()
            filteredPokemon = pokemon
            self.tableView.reloadData()
            isSearching = false
            return
            
        }
        
        isSearching = true
        filteredPokemon = pokemon.filter { $0.name.lowercased().contains(filter.lowercased())}
        self.tableView.reloadData()
    }
    
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            isSearching = false
//            filteredPokemon = pokemon
//            self.tableView.reloadData()
//        }


}
