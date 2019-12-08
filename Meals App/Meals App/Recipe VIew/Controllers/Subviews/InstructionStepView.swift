//
//  InstructionStepView.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class InstructionStepView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stepDescription: UITextView!
    @IBOutlet weak var index: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func commonInit(index : Int, description : String){
        Bundle.main.loadNibNamed("InstructionStepView", owner: self, options: nil)
        contentView.frame = self.bounds
        self.index.layer.masksToBounds = true
        self.index.layer.cornerRadius = self.index.frame.height/2
        addSubview(contentView)
        self.index.text = "\(index)"
        self.stepDescription.text = description
    }

}
