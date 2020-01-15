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
    var saved: Observable<Bool>

    var recipeAPIManager =
        APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756")
        //StubApiRecipManager()
    
    init(saveTap: Observable<Void>, recipeID: Int){
        let recipeManager = RecipeDataManager()
        singleRecipe = recipeAPIManager.fetchRecipeWith(recipeId: recipeID)
        
        saved = saveTap.withLatestFrom(self.singleRecipe.asObservable())
        .flatMapLatest { recipe in
            return recipeManager.saveRecipe(recipe: recipe)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(false)
        }
    }
    
    init(savedRecipeId id: Int) {
        let recipeManager = RecipeDataManager()
        singleRecipe = Single<Recipe>.create{
            single in
            do{
                let recipe = try recipeManager.getRecipe(withId: id)
                single(.success(recipe))
            }catch{
                print("DataManagerError: Not Found Recipe With id = \(id)")
            }
            return Disposables.create()
        }
        
        saved = Observable<Bool>.create{ observable in
            observable.onNext(true)
            return Disposables.create()
        }
    }
    
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
