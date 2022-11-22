//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-21.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    static let reuseID = "PokemonCell"
    
    let avatarImage = Image(frame: .zero)
    let nameLabel = Label(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(pokemon: PokemonEntry) {
        //avatarImage.setSprite(from: pokemon.url)
        nameLabel.text = pokemon.name
    }
    
    private func configure() {
        addSubview(avatarImage)
        addSubview(nameLabel)
        
        accessoryType = .disclosureIndicator

        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
