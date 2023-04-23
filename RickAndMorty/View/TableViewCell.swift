//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Mac on 16.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var imageViev: UIImageView!
    @IBOutlet var genderView: UIImageView!
    @IBOutlet weak var textLabellll: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViev.layer.borderWidth = 3
        imageViev.layer.cornerRadius = 20
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
