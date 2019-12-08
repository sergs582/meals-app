//
//  RecipeViewController.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var instructions: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoCollection: InfoCollectionView!
    @IBOutlet weak var ingredientsCollection: IngredientsCollectionView!
    var viewModel = RecipeViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupNavigationBar()
        headerView.commonInit(imageURL: viewModel.headerImageURL, title: viewModel.recipeTitle)
        infoCollection.commonInit(information: viewModel.information)
        ingredientsCollection.commonInit(ingredients: viewModel.ingredients)
        instructions.instructionInit(instructions: viewModel.instructions)
    }
    
    func setupNavigationBar(){
        topConstraint.constant = -(navigationController?.navigationBar.frame.height)! - statusBarHeight()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
    func statusBarHeight() -> CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

}

fileprivate extension UIStackView {
    
    func instructionInit(instructions : [Int : String]){
        for i in 1...instructions.count{
            let step = InstructionStepView()
            step.commonInit(index: i, description: instructions[i]!)
            self.addArrangedSubview(step)
        }
    }
    
}
