//
//  RecipeManagers.swift
//  Meals App
//
//  Created by Сергей on 16.01.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import Foundation
import RxSwift

class SearchRecipesManager: SearchDataManager {
    
    func getRecipes(withName name: String) -> Observable<SearchRecipesResponse> {
        return APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756").fetchRecipeWith(recipeName: name, number: 30)
    }

}

class CoreDataRecipeManager: DataManager{
    func getRecipe(withID id: Int) -> Single<Recipe> {
       return Single<Recipe>.create{
            single in
            do{
                let recipe = try RecipeDataManager().getRecipe(withId: id)
                single(.success(recipe))
            }catch{
                print("DataManagerError: Not Found Recipe With id = \(id)")
            }
            return Disposables.create()
        }
    }
}

class RecipeManager: DataManager{
    func getRecipe(withID id: Int) -> Single<Recipe> {
        return APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756").fetchRecipeWith(recipeId: id)
    }
}
