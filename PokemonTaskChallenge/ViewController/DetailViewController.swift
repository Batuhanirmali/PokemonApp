//
//  DetailViewController.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 23.03.2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: DetailViewModel?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abilitiesFirstLabel: UILabel!
    @IBOutlet weak var abilitiesSecondLabel: UILabel!
    @IBOutlet weak var typeFirstLabel: UILabel!
    @IBOutlet weak var typeSecondLabel: UILabel!
    @IBOutlet weak var statHpLabel: UILabel!
    @IBOutlet weak var statAttackLabel: UILabel!
    @IBOutlet weak var statDefenseLabel: UILabel!
    @IBOutlet weak var statSpeedLabel: UILabel!
    @IBOutlet weak var statHpProgressBar: UIProgressView!
    @IBOutlet weak var statAttackProgressBar: UIProgressView!
    @IBOutlet weak var statDefenseProgressBar: UIProgressView!
    @IBOutlet weak var statSpeedProgressBar: UIProgressView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLabel()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        viewModel?.fetchPokemonDetails(completion: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.nameLabel.text = self.viewModel?.name ?? ""
                
                let abilitiesCount: Int = self.viewModel?.abilities?.count ?? 0
                
                if abilitiesCount >= 2 {
                    self.abilitiesFirstLabel.text = self.viewModel?.abilities?[0].ability?.name ?? "Unknown"
                    self.abilitiesSecondLabel.text = self.viewModel?.abilities?[1].ability?.name ?? "Unknown"
            
                } else if abilitiesCount == 1 {
                    self.abilitiesFirstLabel.text = self.viewModel?.abilities?[0].ability?.name ?? "Unknown"
                } else {
                    self.abilitiesFirstLabel.isHidden = true
                    self.abilitiesSecondLabel.isHidden = true
                }
                
                let typeCount: Int = self.viewModel?.types?.count ?? 0
                if typeCount >= 2 {
                    self.typeFirstLabel.text = self.viewModel?.types?[0].type?.name ?? "Unknown"
                    self.typeSecondLabel.text = self.viewModel?.types?[1].type?.name ?? "Unknown"
            
                } else if abilitiesCount == 1 {
                    self.typeFirstLabel.text = self.viewModel?.types?[0].type?.name ?? "Unknown"
                } else {
                    self.typeFirstLabel.isHidden = true
                    self.typeSecondLabel.isHidden = true
                }
                
                self.setProgressBar()
                
                
                self.statHpLabel.text = "Hp"
                self.statAttackLabel.text = "Attack"
                self.statDefenseLabel.text = "Defense"
                self.statSpeedLabel.text = "Speed"
                
                if let imageURL = self.viewModel?.imageURL {
                    self.imageView.sd_setImage(with: imageURL)
                }
            }
        })
    }
    
    // MARK: - SetProgressBar
    
    func animateStatBars(value: Float, bar: UIProgressView) {
        bar.setProgress(value, animated: true)
    }
    func formatFloat(value: Int) -> Float {
        var formatedValue: Float = (Float(value) * 1.0) / 120
        return formatedValue
    }
    
    func setProgressBar() {
        let hp        : Int = viewModel?.stats?[0].baseStat ?? 00
        let attack        : Int = viewModel?.stats?[1].baseStat ?? 00
        let defense        : Int = viewModel?.stats?[2].baseStat ?? 00
        let speed        : Int = viewModel?.stats?[3].baseStat ?? 00
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.animateStatBars(value: self.formatFloat(value: hp), bar: self.statHpProgressBar)
            self.animateStatBars(value: self.formatFloat(value: attack), bar: self.statAttackProgressBar)
            self.animateStatBars(value: self.formatFloat(value: defense), bar: self.statDefenseProgressBar)
            self.animateStatBars(value: self.formatFloat(value: speed), bar: self.statSpeedProgressBar)

            
        }
        statHpProgressBar.transform  = statHpProgressBar.transform.scaledBy(x: 1, y: 0.5)
        statAttackProgressBar.transform  = statAttackProgressBar.transform.scaledBy(x: 1, y: 0.5)
        statDefenseProgressBar.transform  = statDefenseProgressBar.transform.scaledBy(x: 1, y: 0.5)
        statSpeedProgressBar.transform  = statSpeedProgressBar.transform.scaledBy(x: 1, y: 0.5)

        

    }

    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func configureLabel() {
        setupLabelRadius()
    }
    
    func setupLabelRadius() {
        abilitiesFirstLabel?.layer.cornerRadius      = 16
        abilitiesFirstLabel?.layer.masksToBounds     = true
        abilitiesSecondLabel?.layer.cornerRadius     = 16
        abilitiesSecondLabel?.layer.masksToBounds    = true
        
        typeFirstLabel?.layer.cornerRadius      = 16
        typeFirstLabel?.layer.masksToBounds     = true
        typeSecondLabel?.layer.cornerRadius     = 16
        typeSecondLabel?.layer.masksToBounds    = true
    }
}
