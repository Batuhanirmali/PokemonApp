//
//  PokemonTableViewCell.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 22.03.2023.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func loadImage(from url: URL?) {
            guard let url = url else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.pokemonImageView.image = image
                    }
                }
            }.resume()
        }
    
}
