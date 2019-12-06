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
    @IBOutlet weak var arg: UITextView!
    @IBOutlet weak var index: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("InstructionStepView", owner: self, options: nil)
        contentView.frame = self.bounds
        index.layer.masksToBounds = true
        index.layer.cornerRadius = index.frame.height/2
        addSubview(contentView)
    }

}
