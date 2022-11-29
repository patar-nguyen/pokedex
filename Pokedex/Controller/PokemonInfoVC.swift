//
//  PokemonInfoVC.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-22.
//

import UIKit

class PokemonInfoVC: UIViewController {

    let headerView = UIView()
        
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getPokemonInfo(name: name)
    }
    
    init(name: String) {
        self.name = name
        //self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getPokemonInfo(name: String) {
        NetworkManager.shared.getPokemonInfo(for: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.addToView(childVC: Info(pokemonInfo: pokemon), to: self.headerView)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .secondarySystemBackground
        headerView.layer.cornerRadius = 18
        
        NSLayoutConstraint.activate([
            headerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }

    func addToView(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
}
