//
//  IngredientsCollectionViewCell.swift
//  Fridgy Recipes
//
//  Created by Сергей on 05.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var imageFrameView: UIView!
    @IBOutlet weak var width: NSLayoutConstraint!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var name : String!
    var amountInMetric : String!
    var imageURL : URL?
  
    func commonInit(){
        setupContent(for: imageFrameView)
        nameLabel.text = name
        amountLabel.text = amountInMetric
       
        loadImage()
    }
    
    func loadImage(){
           if let imageURL = imageURL{
           DispatchQueue.global().async {
             if let data = try? Data(contentsOf: imageURL),
                 let image = UIImage(data: data){
                 DispatchQueue.main.async {
                   self.picture.image = image
                 }
             }
             }
             }
       }
    
    func setupContent(for view : UIView){
        width.constant = self.frame.width
        view.layer.cornerRadius = 15
        picture.layer.cornerRadius = 15
        picture.clipsToBounds = true
        ShadowToView(view)
    }
    
    func ShadowToView(_ view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
    }
 
}
