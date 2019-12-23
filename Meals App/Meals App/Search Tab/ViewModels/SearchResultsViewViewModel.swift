//
//  SearchResultsViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class SearchResultsViewViewModel {
    
    var recipes : Box<[SearchRecipe]?> = Box([SearchRecipe]())
    var newItems : [SearchRecipe]?
    var fetchingMore = false
    func recipesCount() -> Int{
      return recipes.value?.count ?? 0
    }
    var searchQuery : Box<String?> = Box(nil)
    
    func imageURL(at index : Int) -> URL?{
        return URL(string: "https://spoonacular.com/recipeImages/\(recipes.value?[index].image ?? "")")
    }
    
    func recipe(at index: Int) -> Recipe{
        return recipes.value?[index].toRecipe() ?? Recipe()
    }
    func recipeTitle(at index : Int) -> String{
        return recipes.value?[index].title ?? ""
    }
    
    func recipeCuisine(at index : Int) -> String{
        return recipes.value?[index].toRecipe().cuisine ?? "International"
    }
    
    
    var searchRecipeManager = APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756")
    
    
    func fetchResults(query: String?, number: Int){
        guard let query = query else { return }
        searchRecipeManager.fetchRecipeWith(recipeName: query, number: number) {  (result) in
            switch result {
            case .Success(let recipes):
                if (self.recipes.value!.count >= 10 && self.recipes.value!.count < 100 && self.fetchingMore) {
                    self.recipes.value!.append(contentsOf: recipes.results)
                    self.recipes.value = NSSet(array: self.recipes.value!).allObjects as? [SearchRecipe]
                }else if self.recipes.value!.count < 10{
                    self.recipes.value = recipes.results
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    init() {
    }
    
}
