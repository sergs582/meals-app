//
//  RecipeViewController.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RecipeViewController: UIViewController, UIScrollViewDelegate, HeaderViewDelegate {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var instructions: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoCollection: InfoCollectionView!
    @IBOutlet weak var ingredientsCollection: IngredientsCollectionView!
    var viewModel : RecipeViewViewModel!
    var disposeBag : DisposeBag!
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag = DisposeBag()
        scrollView.delegate = self
        setupNavigationBar()
        headerView.delegate = self
        headerView.commonInit()
        commonInit(recipe: Recipe(title: "Title", information: [], ingredients: [], savedIngredients: [], instruction: []))
        setupViewModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func commonInit(recipe: Recipe){
        
        headerView.setupHW(imageURL: URL(string: recipe.imageURL), image: recipe.image, title: recipe.title)
        
        infoCollection.commonInit(information: recipe.information)
        ingredientsCollection.commonInit(ingredients: recipe.ingredients, savedIngredients: recipe.savedIngredients)
        ingredientsCollection.reloadData()
        guard recipe.instruction.count == 0 else{
            instructions.instructionInit(steps: recipe.instruction[0].steps)
          return
        }
    }
    func setupViewModel(){
        viewModel = RecipeViewViewModel(saveTap: headerView.save.rx.tap.asObservable(), recipeID: id)
        
        viewModel.singleRecipe
            .subscribe(
                onSuccess: { recipe in
                    DispatchQueue.main.async {
                        self.commonInit(recipe: recipe.toRecipe())
                    }
                },
                onError: { error in
                    print(error)
                })
            .disposed(by: disposeBag)
                 
        viewModel.saved
            .subscribe{ event in
                if event.element! {
                    self.headerView.save.backgroundColor = .green
                    self.headerView.save.setTitle("Saved", for: .normal)
                }else{
                    self.headerView.save.setTitle("Error", for: .normal)
                }

            }
            .disposed(by: disposeBag)
    }
    
    func addToFavourite() {
      //  viewModel.addToFavourite()
    }
    
    func setupNavigationBar(){
        topConstraint.constant = -(navigationController?.navigationBar.frame.height)! - statusBarHeight()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
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
    func instructionInit(steps : [Step]){
        guard steps.count != 0 else { return }
        for i in 0..<steps.count{
            let step = InstructionStepView()
            step.commonInit(index: steps[i].number, description: steps[i].step)
            self.addArrangedSubview(step)
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
