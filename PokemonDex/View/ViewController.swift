//
//  ViewController.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 11/10/22.
//

import UIKit

import Foundation

import SDWebImage


var searchController: UISearchController!


var dataPokemon = [String]()
var filteredPokemon = [String]()
var sholdShowSearchResults = false



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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

        //chamada da API
        API.makeRequest{
            (cards) in
            self.data = cards
            print(cards)
        }
        
        view.addSubview(tableView)
        
        tableView.register(
            UINib(nibName: "CardUICell", bundle: nil),
            forCellReuseIdentifier: "cell"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        // Tirar o feito de cell tepped (Verificar, pois isso torna a tableView não selecionável)
        tableView.allowsSelection = false
        //chamando as constranins
        setConstrains()
       
        
    }
    
    //searchbar
    
    
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = data?.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardUICell
        cell.configure(with: card ?? Card(id: "", name: "", images: Images(large: "")) )
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped \(indexPath.row)")
    }
    
    //
    func setConstrains(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
}

