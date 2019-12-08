//
//  InfoCollectionViewCell.swift
//  Fridgy Recipes
//
//  Created by Сергей on 05.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class InfoCollectionViewCell : UICollectionViewCell{
    
    
    @IBOutlet weak var view : UIView!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var label : UILabel!
    
    var title : String!
    var imageURL : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = view.frame.height/2
        image.clipsToBounds = true
        ShadowToView(view)
    }
    
    func commonInit(){
        label.text = title
        
    }
    
    func ShadowToView(_ view : UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: -1)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2
    }
}
