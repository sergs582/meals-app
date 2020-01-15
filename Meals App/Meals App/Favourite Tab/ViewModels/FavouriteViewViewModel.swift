//
//  FavouriteViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift

class FavouriteViewViewModel {
    
    var recipes : BehaviorSubject<[Recipe]>
   
    private var recipeManager = RecipeDataManager()
    
    func deleteRecipeWith(index: Int){
        guard let changedRecipes = try? recipes.value() else { return }
        let id = changedRecipes[index].id
        recipeManager.deleteRecipe(withId: id)
        update()
    }

    func update(){
        recipes.onNext(recipeManager.toRecipeArray())
    }
    
    var selectedType : ResultsType = .favourite
    var recipeViewModel : RecipeViewViewModel!
    
    init() {
        recipes = BehaviorSubject<[Recipe]>(value: recipeManager.toRecipeArray())
    }
    
}
