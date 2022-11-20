//
//  PokedexVC.swift
//  Pokedex
//
//  Created by Patrick Nguyen on 2022-11-20.
//

import UIKit

class PokedexVC: UIViewController {

    var trainerName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        navigationController?.isNavigationBarHidden = false
    }
    
//    init(trainerName: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.trainerName = trainerName
//        title = trainerName
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}
