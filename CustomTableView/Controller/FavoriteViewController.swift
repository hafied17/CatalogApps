//
//  FavoriteViewController.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var imageGameFavorite: UIImageView!
    @IBOutlet weak var favoriteTebleView: UITableView!
    var urlString = ""
    private var favorites: [FavoriteModel] = []
    private var favoriteId: Int = 0
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Game Favorite"
        setupView()
    }
    
    

    private func setupView() {
        favoriteTebleView.delegate = self
        favoriteTebleView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMembers()
        self.tabBarController?.tabBar.isHidden = false
    }

    private func loadMembers() {
        self.favoriteProvider.getAllFavorite { result in
            DispatchQueue.main.async {
                self.favorites = result
                self.favoriteTebleView.reloadData()
            }
        }
    }

}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell {
            let favorite = favorites[indexPath.row]
            cell.nameGameFavorite.text = favorite.nameGame!
            cell.ratingGameFavorite.text = "\(favorite.rating!)"
            cell.releaseGameFavorite.text = "\(favorite.released!)"
            self.urlString = "\(favorite.image!)"
            cell.imageGameFavorite.sd_setImage(with: URL(string: urlString),
                                  placeholderImage: UIImage(systemName: "photo"),
                                  options: .continueInBackground,
                                  completed: nil)

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(identifier: "FavoriteDetailViewController") as? FavoriteDetailViewController
        detail?.idGameF = "\(favorites[indexPath.row].idGame!)"
        detail?.idGameCD = favorites[indexPath.row].id
        self.navigationController?.pushViewController(detail!, animated: true)
    }
}

