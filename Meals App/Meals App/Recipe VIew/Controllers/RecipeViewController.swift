//
//  RecipeViewController.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UIScrollViewDelegate, HeaderViewDelegate {

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
        commonInit()
        headerView.delegate = self
        guard viewModel.recipe.value?.image != nil else {
            viewModel.recipe.bind {  (recipe) in
                DispatchQueue.main.async {
                    self.commonInit()
                }
            }
            return
        }
        
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func commonInit(){
        
        headerView.commonInit(imageURL: viewModel.headerImageURL, image: viewModel.recipe.value?.image, title: viewModel.recipeTitle)
        infoCollection.commonInit(information: viewModel.information!)
        ingredientsCollection.commonInit(ingredients: viewModel.ingredients, savedIngredients: viewModel.recipe.value?.savedIngredients)
        ingredientsCollection.reloadData()
        guard viewModel.instructions.count == 0 else{
        instructions.instructionInit(steps: viewModel.instructions[0].steps)
        return
    }
    }
    
    func addToFavourite() {
        viewModel.addToFavourite()
    }
    func addLoadedData(data: Data) {
       // viewModel.recipe.value?.image = data
    }
    
    
    func setupNavigationBar(){
        topConstraint.constant = -(navigationController?.navigationBar.frame.height)! - statusBarHeight()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.bounces = scrollView.contentOffset.y > 100
//    }
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
    
    func instructionInit(steps : [Step]){
        print(steps.count)
        guard steps.count != 0 else { return }
        for i in 0..<steps.count{
            let step = InstructionStepView()
            step.commonInit(index: steps[i].number, description: steps[i].step)
            self.addArrangedSubview(step)
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
