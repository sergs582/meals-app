//
//  RecipeViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift

class RecipeViewViewModel {

    var recipeManager = RecipeDataManager()
    var singleRecipe : Single<Recipe>
    let disposeBag = DisposeBag()
    var saved: Observable<Bool>?
    var dataManager: DataManager
    
    init(recipeID: Int, dataManager: DataManager) {
        self.dataManager = dataManager
        singleRecipe = dataManager.getRecipe(withID: recipeID)
        
    }
    
    func setup(input: Observable<Void>) {
        saved = input.withLatestFrom(self.singleRecipe.asObservable())
        .flatMapLatest { recipe in
            return self.recipeManager.saveRecipe(recipe: recipe)
        .observeOn(MainScheduler.instance)
        .catchErrorJustReturn(false)
        }
    }
}
