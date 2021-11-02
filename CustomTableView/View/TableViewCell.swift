//
//  TableViewCell.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 23/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ratingTop: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var titleLabel01: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var textLabel01: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
