//
//  HeaderView.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var save: UIButton!
    var imageURL : URL?
    weak var delegate : HeaderViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    

    
    @IBAction func addToFavourite(_ sender: Any) {
        delegate.addToFavourite()
        save.backgroundColor = .green
        save.isEnabled = false
        save.setTitle("Saved", for: .normal)
    }
    
    func commonInit(imageURL: URL?, image: Data?, title: String){
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        self.imageURL = imageURL
        contentView.fixInView(self)
        self.title.text = title
        save.layer.cornerRadius = 5
        if let image = image{
          self.headerImage.image = UIImage(data: image)
        }else{
            guard let imageURL = imageURL else { return }
            self.headerImage.kf.setImage(with: imageURL)
        }
    }
}

extension UIView{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
