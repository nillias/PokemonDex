//
//  CardSaveViewController.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 20/10/22.
//

import UIKit

class CardSaveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var dataSave: [CardSalvo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    lazy var tableView =  {
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        guard let fecthData = CoreDataManager.shared.fetchSaveCards() else { return }
        dataSave = fecthData

        
        tableView.register(
            UINib(nibName: "CardUICell", bundle: nil),
            forCellReuseIdentifier: "cell"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        setConstrains()
    }
    
    func setConstrains(){
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSave.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardUICell
       
        cell.configFromCoreData(with: dataSave[indexPath.row])
        cell.removeButton()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(dataSave[indexPath.row].url ?? "")
        
    }
    
}





