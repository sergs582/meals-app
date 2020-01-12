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
    
    var recipe : Box<Recipe?> = Box(nil)
    var recipeManager = RecipeDataManager()
    var singleRecipe : Single<RecipeResponse>
    let disposeBag = DisposeBag()
    var saved: Observable<Bool>
    
    
    
    
    var recipeTitle: String {
        return recipe.value?.title ?? "Title"
    }
    var headerImageURL: URL? {
        return URL(string: recipe.value?.imageURL ?? "")
    }
    var cuisine: String? {
        return recipe.value?.cuisine
    }
    
    func infoImageName(atIndex index : Int) -> String? {
        return recipe.value?.information[index].imageName
    }
    func ingredientImageURL(atIndex index : Int) -> URL {
        return (recipe.value?.ingredients[index].imageURL())!
    }
    func informationCount() -> Int {
        return recipe.value?.information.count ?? 0
    }
    var information : [RecipeInfo]? {
        return recipe.value?.information ?? [RecipeInfo]()
    }
    func ingredientsCount() -> Int {
        return recipe.value?.ingredients.count ?? 0
    }
    var ingredients : [Ingredient] {
        return recipe.value?.ingredients ?? [Ingredient]()
    }
    func instructionsCount() -> Int {
        return recipe.value?.information.count ?? 0
    }
    var instructions : [RecipeInstruction] {
        return recipe.value?.instruction ?? [RecipeInstruction]()
    }
    
    var recipeAPIManager =
        APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756")
        //StubApiRecipManager()
    
    init(saveTap: Observable<Void>, recipeID: Int){
       let recipeManager = RecipeDataManager()
        singleRecipe = recipeAPIManager.fetchRecipeWith(recipeId: recipeID)
        
        saved = saveTap.withLatestFrom(self.singleRecipe.asObservable())
        .flatMapLatest { recipe in
            return recipeManager.saveRecipe(recipe: recipe.toRecipe())
                .observeOn(MainScheduler.instance)
                //.catchErrorJustReturn(false)
        }
        
    }
    
//  init(savedRecipe recipe: Recipe) {
//
//    }
    
    func fetchResult(recipeId: Int) {
        recipeAPIManager.fetchRecipeWith(recipeId: recipeId) { (result) in
            switch result {
                case .Success(_):
                print("")
                    //self.recipeSubject.onNext(recipe.toRecipe())
                case .Failure(let error):
                    print(error)
            }
        }
        
    }
}
