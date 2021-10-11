//
//  MovieTableViewCell.swift
//  Swift Practice # 92 Airtable And Movie
//
//  Created by Dogpa's MBAir M1 on 2021/10/11.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moviePhotoImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
