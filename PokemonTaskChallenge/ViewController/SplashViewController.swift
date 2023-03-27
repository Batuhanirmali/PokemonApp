//
//  SplashViewController.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 26.03.2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    let animationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "splashToMain", sender: nil)
            self.animationView.stop()
        }
    }
    
    private func setupAnimation(){
        animationView.animation = LottieAnimation.named("poke")
        animationView.frame = view.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)

    }
    
    
}
