//
//  FavouriteViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class FavouriteViewViewModel {
    
     var recipes : Box<[Recipe]?> = Box(nil)
    
    func recipesCount() -> Int{
        return recipes.value?.count ?? 0
    }
    
    func recipeImage(at index : Int) -> Data?{
        return recipes.value?[index].image
    }
    
    func recipeTitle(at index : Int) -> String{
        return recipes.value?[index].title ?? "Title"
    }
    
    func recipeCuisine(at index : Int) -> String{
        return recipes.value?[index].cuisine ?? "International"
    }
    
    private var recipeModel = RecipeModel()
    
    func deleteRecipeWith(index: Int){
        recipeModel.deleteRecipe(withId: recipes.value![index].id)
        recipes.value = recipeModel.toRecipeArray()
    }

    
    var selectedType : ResultsType = .favourite
    
    var recipeViewModel = RecipeViewViewModel()
    
    init() {
        recipes.value = recipeModel.toRecipeArray()
    }
    
}
