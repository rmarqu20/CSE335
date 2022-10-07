//
//  CityTableViewCell.swift
//  Lab4
//
//  Created by Richard Marquez on 2/28/22.
//

import UIKit

class CityTableViewCell: UITableViewCell
{
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    {
        didSet
        {
            cityImage.layer.cornerRadius = cityImage.bounds.width / 4
            cityImage.clipsToBounds = true
        }
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
