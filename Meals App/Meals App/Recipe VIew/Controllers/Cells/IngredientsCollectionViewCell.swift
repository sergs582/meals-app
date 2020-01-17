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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageFrameView: UIView!
    @IBOutlet weak var width: NSLayoutConstraint!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var name : String!
    var amountInMetric : String!
    var imageURL : URL?
    var imageData : Data?
    
    func commonInit() {
        setupContent(for: imageFrameView)
        nameLabel.text = name
        amountLabel.text = amountInMetric
        if imageData == nil {
            guard let imageURL = imageURL else { return }
            image.kf.setImage(with: imageURL)
        }else{
            image.image = UIImage(data: imageData!)
        }
    }
    
    func setupContent(for view : UIView) {
        width.constant = self.frame.width
        view.layer.cornerRadius = 15
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        shadowToView(view)
    }
    
    func shadowToView(_ view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
    }
}
