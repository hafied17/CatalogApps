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
    
    var idgameF = ""
    var describF = ""
    var nameF = ""
    var genreF = ""
    var webF = ""
    var ratingF = ""
    var releasedF = ""
    var imageF = ""
    var developerF = ""

    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()

    var favoriteId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAPI()
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10

    }
    
    @IBAction func test(_ sender: Any) {
        saveFavorite()

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }



    func detailAPI() {
        guard let gitUrl = URL(string: "https://api.rawg.io/api/games/\(idGame)?key=89e15c9492fa4780a2dccd7244217799") else { return }
        let request = URLRequest(url: gitUrl)
            
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
                
        guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(GameDetail.self, from: data)
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
                    self.idgameF = "\(data.id)"
                    self.nameF = "\(data.name)"
                    self.genreF = "\(data.genres[0].name)"
                    self.webF = "\(data.website)"
                    self.ratingF = "\(data.rating)"
                    self.releasedF = "\(data.released)"
                    self.imageF = "\(data.backgroundImage)"
                    self.developerF = "\(data.developers[0].name)"
                    
                }

                
                }catch let err{
                    print("Error", err)
                }
            }.resume()
            
        }
    
    private func saveFavorite() {
        favoriteProvider.createFavorite(describF, developerF, genreF, idgameF, imageF, nameF, ratingF, releasedF, webF) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Successful", message: "Favorite game has been added!", preferredStyle: .alert)
                            
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
    }

}
