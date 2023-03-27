//
//  ViewController.swift
//  PokemonTaskChallenge
//
//  Created by Talha Batuhan Irmalı on 22.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    private var viewModel: MainViewModel!
    private var activityIndicatorView: UIActivityIndicatorView!


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupTableView()
            setupActivityIndicatorView()
            setupViewModel()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.center = tableView.center
        tableView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func setupViewModel() {
        viewModel = MainViewModel()
        viewModel.delegate = self
        viewModel.fetchPokemons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow {
            let pokemon = viewModel.pokemons[indexPath.row]
            
            detailVC.viewModel = DetailViewModel.init(pokemonId: "\(indexPath.row + 1)", name: pokemon.name, imageURL: viewModel.getPokemonDetailURL(for: indexPath.row), apiService: PokeAPIService())
        }
        
    }
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? PokemonTableViewCell {
            let pokemon = viewModel.pokemons[indexPath.row]
            cell.nameLabel.text = pokemon.name
            
            cell.loadImage(from: viewModel.getPokemonSpritesURL(for: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = viewModel.pokemons[indexPath.row].name
            navigationItem.backBarButtonItem = backBarBtnItem
    }
    
}
extension MainViewController: MainViewModelDelegate {
    func didFetchPokemons() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

