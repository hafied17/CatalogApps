//
//  TestViewController.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 30/10/21.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var textgame: UITextView!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var web: UILabel!
    @IBOutlet weak var date: UILabel!
    var idGame = ""
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAPI()
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10

    }
    

    func detailAPI() {
        guard let girURL = URL(string: "https://api.rawg.io/api/games/\(idGame)?key=89e15c9492fa4780a2dccd7244217799") else {return}
        var request = URLRequest(url:girURL)
            
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
                
        guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(Detail.self, from: data)
                DispatchQueue.main.async {
                    self.nameGame.text = "\(data.name)"
                    self.textgame.text = "\(data.welcomeDescription)"
                    self.rating.text = "\(data.rating)/5.0"
                    self.date.text = "\(data.released)"
                    self.web.text = "\(data.website)"
                    self.genre.text = "\(data.genres[0].name)"
                    self.developer.text = "\(data.developers[0].name)"
                    self.urlString = "\(data.backgroundImage)"
                    self.imageGame.contentMode = UIView.ContentMode.scaleToFill
                    self.imageGame.sd_setImage(with: URL(string: self.urlString),
                                          placeholderImage: UIImage(systemName: "photo"),
                                          options: .continueInBackground,
                                          completed: nil)
                }

                
                }catch let err{
                    print("Error", err)
                }
            }.resume()
            
        }

}
