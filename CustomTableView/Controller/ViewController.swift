//
//  ViewController.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 23/10/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var urlString = ""
    var idGame = ""
    let parser = Parser()
    var result = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List Game"
        parser.parse {
            data in
            self.result = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        self.urlString = "\(result[indexPath.row].backgroundImage)"
        cell.imageGame.layer.cornerRadius = 5
        cell.imageGame.contentMode = UIView.ContentMode.scaleToFill
        cell.imageGame.sd_setImage(with: URL(string: urlString),
                              placeholderImage: UIImage(systemName: "photo"),
                              options: .continueInBackground,
                              completed: nil)
        cell.titleLabel01.text = result[indexPath.row].name
        cell.textLabel01.text = result[indexPath.row].released
        cell.rating.text = "\(result[indexPath.row].rating)"
        cell.ratingTop.text = "\(result[indexPath.row].ratingTop)"

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(identifier: "TestViewController") as? TestViewController
        detail?.idGame = "\(result[indexPath.row].id)"
        self.navigationController?.pushViewController(detail!, animated: true)
    }
}

