//
//  FavoriteDetailViewController.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import UIKit

class FavoriteDetailViewController: UIViewController {

    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var web: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()

    var idGameF = ""
    var idGameCD: Int32?
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        detailAPI()
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete this Game from Favorite?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.deleteMember()
        })

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    private func deleteMember() {
        favoriteProvider.deleteMember(idGameCD!) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Successful", message: "The game has been deleted from favorites.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    
    func detailAPI() {
        guard let gitUrl = URL(string: "https://api.rawg.io/api/games/\(idGameF)?key=89e15c9492fa4780a2dccd7244217799") else { return }
        let request = URLRequest(url: gitUrl)
            
        URLSession.shared.dataTask(with: request) { (data, respone, error) in
                
        guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(GameDetail.self, from: data)
                DispatchQueue.main.async {
                    self.nameGame.text = "\(data.name)"
                    self.desc.text = "\(data.welcomeDescription)"
                    self.rating.text = "\(data.rating)/5.0"
                    self.released.text = "\(data.released)"
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
