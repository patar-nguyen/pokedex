//
//  Image.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-21.
//

import UIKit

class Image: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholder = UIImage(named: "placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setSprite(from url: String) {
        NetworkManager.shared.getSprites(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let sprite):
                print(sprite.front_default)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}
