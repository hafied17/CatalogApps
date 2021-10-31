//
//  Parser.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 29/10/21.
//

import Foundation

struct Parser {
    
    func parse(comp : @escaping ([Result])->()) {
        let api = URL(string: "https://api.rawg.io/api/games?page_size=10&key=89e15c9492fa4780a2dccd7244217799")
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {
//                print(error?.localizedDescription)
                return
            }
            do {
                let result = try JSONDecoder().decode(Welcome.self, from: data!)
                comp(result.results)
            } catch {
            
            }
        }.resume()
    }
}
