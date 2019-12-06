//
//  FavouriteCell.swift
//  Fridgy Recipes
//
//  Created by Сергей on 22.11.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    
    @IBOutlet weak var imageForCell: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    
    var imageName : String?
    var titleText : String?
    var descriptionText : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit(){
        imageForCell.image = UIImage.init(named: imageName!)
        title.text = titleText
        shortDescription.text = descriptionText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
