//
//  DetailsGameViewController.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 30/10/21.
//

import UIKit

class DetailsGameViewController: UIViewController {

    @IBOutlet weak var imageGameDetails: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var descriptionGame: UITextView!
    @IBOutlet weak var web: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var release: UILabel!
    @IBOutlet weak var developer: UILabel!
    
    var idGame = ""
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.layer.cornerRadius = 5
        view2.layer.cornerRadius = 5

//        detailAPI()
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
                    self.descriptionGame.text = "\(data.welcomeDescription)"
                    self.rating.text = "\(data.rating)"
                    self.release.text = "\(data.released)"
                    self.web.text = "\(data.website)"
                    self.genre.text = "\(data.genres)"
                    self.developer.text = "\(data.developers)"
                    self.urlString = "\(data.backgroundImage)"
                    self.imageGameDetails.contentMode = UIView.ContentMode.scaleToFill
                    self.imageGameDetails.sd_setImage(with: URL(string: self.urlString),
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
