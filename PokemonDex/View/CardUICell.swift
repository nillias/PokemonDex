//
//  CardUICell.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 17/10/22.
//

import UIKit

class CardUICell: UITableViewCell {
    
    var pokemonURL: URL?
    
    @IBOutlet weak var buttomCard: UIButton!
    @IBOutlet weak var pokemonImage: UIImageView!
    weak var delegate: CellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttomCard.setTitle("Save", for: .normal)
        buttomCard.tintColor = .systemBlue
        buttomCard.addTarget(self, action: #selector(saveCard), for: .touchUpInside)
        
    }
    
    //funcao do botao para salvar
    @objc func saveCard(){
        
        delegate.saveImage(with: pokemonURL!.absoluteString )
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with pokemom: Card) {
        
        pokemonImage.sd_setImage(with: URL(string: pokemom.images.large))
        pokemonURL = URL(string: pokemom.images.large)
        
    }
    
    func configFromCoreData(with pokemon: CardSalvo) {
        guard let pokemonUnwraped = pokemon.url else {
            return
        }
        pokemonImage.sd_setImage(with: URL(string: pokemonUnwraped))
    }
    
    func removeButton() {
        buttomCard?.removeFromSuperview()
    }
    
}

//protocolo do delegate para salvar a imagem
protocol CellDelegate: AnyObject {
    func saveImage(with url: String)
}
