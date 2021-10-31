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
    let titlesF = [("Apple"),("Apricot"),("Banana"),("Grapes"),("Kiwi"),("Orange"),("Peach")]
    let desF = [("An apple is a sweet, edible fruit produced by an apple tree."),
                ("An apricot is a fruit, or the tree that bears the fruit, of several species in the genus Prunus (stone fruits)."),
                ("A banana is an edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa."),
                ("A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis."),
                ("Kiwifruit, or Chinese gooseberry is the edible berry of several species of woody vines in the genus Actinidia."),
                ("The orange is the fruit of the citrus species Citrus × sinensis in the family Rutaceae. "),
                ("A peach is a soft, juicy and fleshy stone fruit produced by a peach tree.")]
    let imagesF = [UIImage(named: "apple"),
                   UIImage(named: "apricot"),
                   UIImage(named: "banana"),
                   UIImage(named: "grapes"),
                   UIImage(named: "kiwi"),
                   UIImage(named: "orange"),
                   UIImage(named: "peach")]
    
    let parser = Parser()
    
    var result = [Result]()
    
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
//        cell.imageGame.image = self.imagesF[indexPath.row]
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

