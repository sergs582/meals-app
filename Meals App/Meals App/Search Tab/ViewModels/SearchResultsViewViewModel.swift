//
//  SearchResultsViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class SearchResultsViewViewModel {
    
    var recipes : Box<[SearchRecipe]?> = Box(nil)
       
       func recipesCount() -> Int{
        return recipes.value?.count ?? 0
       }
    
       var searchQuery : Box<String?> = Box(nil)
    
    
       func imageURL(at index : Int) -> URL?{
        return URL(string: "https://spoonacular.com/recipeImages/\(recipes.value?[index].image ?? "")")
       }
       
       func recipeTitle(at index : Int) -> String{
        return recipes.value?[index].title ?? ""
       }
       
       func recipeCuisine(at index : Int) -> String{
           return "American"
       }
       
       var recipeViewModel = RecipeViewViewModel()
       var searchRecipeManager = APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756")
    
    
       func fetchResults(query: String?){
        guard let query = query else { return }
        searchRecipeManager.fetchRecipeWith(recipeName: query, number: 10) {  (result) in
            switch result {
            case .Success(let recipes):
                self.recipes.value = recipes.results
                print(recipes.results)
            case .Failure(let error):
                print(error)
            }
        }
        
        
        
    }
       
       init() {
           
       }
    
}
