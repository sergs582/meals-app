//
//  FavouriteViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class FavouriteViewViewModel {
    
    private var recipes = [Recipe]()
    
    func recipesCount() -> Int{
        return recipes.count
    }
    
    func imageURL(at index : Int) -> URL?{
        return URL(string: recipes[index].imageURL)
    }
    
    func recipeTitle(at index : Int) -> String{
        return recipes[index].title
    }
    
    func recipeCuisine(at index : Int) -> String{
        return recipes[index].cuisine ?? "International"
    }
    
    
    var selectedType : ResultsType = .favourite
    
    var recipeViewModel = RecipeViewViewModel()
    
    init() {
       
    }
    
}
