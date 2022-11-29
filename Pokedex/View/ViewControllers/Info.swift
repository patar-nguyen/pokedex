//
//  Info.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-29.
//

import UIKit

class Info: UIViewController {

    var pokemonImage = SpecificImage(frame: .zero)
    var nameLabel = Label(textAlignment: .center, fontSize: 30)
    var idLabel = BodyLabel(textAlighment: .center)
    var heightLabel = BodyLabel(textAlighment: .center)
    var weightLabel = BodyLabel(textAlighment: .center)
    var experienceLabel = BodyLabel(textAlighment: .center)
    
    var pokemonInfo: PokemonInfo!
    
    init(pokemonInfo: PokemonInfo) {
        super.init(nibName: nil, bundle: nil)
        self.pokemonInfo = pokemonInfo
        //self.url = url
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configureUIElements() {
        pokemonImage.setSprite(from: pokemonInfo.sprites.front_default)
        nameLabel.text = pokemonInfo.name.capitalized
        idLabel.text = "# \(pokemonInfo.id)"
        heightLabel.text = "Height: \(pokemonInfo.height)"
        weightLabel.text = "Weight: \(pokemonInfo.weight)"
        experienceLabel.text = "Experience: \(pokemonInfo.base_experience)"

    }
    
    func addSubviews() {
        view.addSubview(pokemonImage)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(experienceLabel)
    }
    
    func layoutUI() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 1),
            pokemonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImage.widthAnchor.constraint(equalToConstant: 180),
            pokemonImage.heightAnchor.constraint(equalToConstant: 180),
            
            nameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),

            idLabel.topAnchor.constraint(equalTo: pokemonImage.topAnchor, constant: 15),
            idLabel.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            idLabel.heightAnchor.constraint(equalToConstant: 20),
            
            heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            experienceLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            experienceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            experienceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            experienceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    


}
