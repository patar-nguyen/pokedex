//
//  Image.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-21.
//

import UIKit

class Image: UIImageView {
    //let cache = NetworkManager.shared.cache
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
    
   // move to different file - poke api
    func setSprite(from url: String) {
        NetworkManager.shared.getSprites(url: url) { result in
            switch result {
            case .success(let sprite):
                NetworkManager.shared.loadImage(url: sprite.front_default) { [weak self] result in
                    switch result {
                    case .success(let image):
                        //ui related has to be on main thread
                        DispatchQueue.main.async { [weak self] in
                            self?.image = image
                        }
                    case .failure(let error):
                        print(error.rawValue)
                    }
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}
