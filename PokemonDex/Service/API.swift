//
//  API.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 17/10/22.
//

import UIKit

struct Data: Codable {
    let data: [Card]
}

struct Card: Codable {
    let id, name: String
    let images: Images
}

struct Images: Codable {
    let large: String
}

class API {

    static func makeRequest(completion: @escaping (Data) -> ()) {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            
            guard let responseData = data else { return }
            
            do {
                let cards = try JSONDecoder().decode(Data.self, from: responseData)

                completion(cards)
            } catch let error {
                    
                print("error: \(error)")
                
            }

        }
        task.resume()
    }
}

