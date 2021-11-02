//
//  FavoriteTableViewCell.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingGameFavorite: UILabel!
    @IBOutlet weak var releaseGameFavorite: UILabel!
    @IBOutlet weak var imageGameFavorite: UIImageView!
    @IBOutlet weak var nameGameFavorite: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
