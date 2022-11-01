//
//  ViewController.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 11/10/22.
//

import UIKit

import Foundation

import SDWebImage

import Lottie

class ViewController: UIViewController {
    
    var animationView: LottieAnimationView?
    
    var isHidden: Bool = false
    
    //searchbar
    let searchController = UISearchController()
    
    
    var cardSaved: [URL] = [ ]
    
    //configuraçoes da table view
    lazy var tableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // atualizção da table view
    var data: Data? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon TCG"
        
        //searchbar
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        //chamada da API
        API.makeRequest{
            (cards) in
            self.data = cards
            
            //print(cards)
            
        }
        
        view.addSubview(tableView)
        
        //registro da xib na celulas a da tableview
        tableView.register(
            UINib(nibName: "CardUICell", bundle: nil),
            forCellReuseIdentifier: "cell"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false // Tirar o efeito de cell tepped (Verificar, pois isso torna a tableView não selecionável)
        
        setConstrains() //chamando as constraints
        
        
        self.animationView = .init(name: "pokebola")
        self.animationView?.frame = CGRect(x: view.frame.midX - 50, y: view.frame.midY, width: 100, height: 100)
        self.view.addSubview(self.animationView!)
        animationView?.loopMode = .loop
        animationView?.layer.opacity = 0.9
        animationView?.play()
        
        
        
    }
    
    //constraints da tableview
    func setConstrains(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = data?.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardUICell
        cell.configure(with: card ?? Card(id: "", name: "", images: Images(large: "")) )
        cell.delegate = self
        
        self.animationView?.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped \(indexPath.row)")
    }
    
    
}

extension ViewController: CellDelegate {
    func saveImage(with url: String) {
        CoreDataManager.shared.createSaveCard(id: "id", url: url)
        let fetch = CoreDataManager.shared.fetchSaveCards()
        print(fetch ?? "")
    }
}

//busca da search bar
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
    
}
