//
//  APIRecipeManager.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift
protocol ApiRecipeManagerProtocolLegacy {
    func fetchRecipeWith(recipeId: Int, completion: @escaping (APIResult<RecipeResponse>) -> Void)
    func fetchRecipeWith(recipeName: String, number: Int, completion: @escaping (APIResult<SearchRecipesResponse>) -> Void)
}


protocol ApiRecipeManagerProtocol {
    func fetchRecipeWith(recipeId: Int) -> Single<RecipeResponse>
    func fetchRecipeWith(recipeName: String, number: Int) -> Observable<SearchRecipesResponse>
}




final class APIRecipeManager: APIManager, ApiRecipeManagerProtocol {
    
    

    
 
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: sessionConfiguration)
    }()
    
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchRecipeWith(recipeId: Int, completion: @escaping (APIResult<RecipeResponse>) -> Void) {
        let baseURL = "https://api.spoonacular.com/recipes/"
        let finalURL = URLConfigurator(baseURL: baseURL,  apiKey: apiKey, recipeId: recipeId).buildRecipeURL()
       
        let request = URLRequest(url: finalURL!)
        fetch(request: request, decode: { (data) -> RecipeResponse? in
            do{
                let recipes = try JSONDecoder().decode(RecipeResponse.self, from: data)
                return recipes
            }catch let error {
                print(error)
                return nil
            }
        }, completion: completion)
        
    }
    func fetchRecipeWith(recipeName: String, number: Int, completion: @escaping (APIResult<SearchRecipesResponse>) -> Void) {
        let baseURL = "https://api.spoonacular.com/recipes/search?"
        let finalURL = URLConfigurator(baseURL: baseURL, query: recipeName, number: number, apiKey: apiKey).buildSearchURL()
        let request = URLRequest(url: finalURL!)
        fetch(request: request, decode: { (data) -> SearchRecipesResponse? in
            do{
                let recipes = try JSONDecoder().decode(SearchRecipesResponse.self, from: data)
                return recipes
            }catch let error {
                print(error)
                return nil
            }
        }, completion: completion)
    }
    
    func fetchRecipeWith(recipeId: Int) -> Single<RecipeResponse> {
        let baseURL = "https://api.spoonacular.com/recipes/"
        let finalURL = URLConfigurator(baseURL: baseURL,  apiKey: apiKey, recipeId: recipeId).buildRecipeURL()
        let request = URLRequest(url: finalURL!)
        let singleRecipe: Single<RecipeResponse>! = fetch(request: request) { (data) in
            do{
                let recipes = try JSONDecoder().decode(RecipeResponse.self, from: data)
                return recipes
            }catch let error {
                print(error)
                return nil
            }
        }
        
        return singleRecipe
     }
     
     func fetchRecipeWith(recipeName: String, number: Int) -> Observable<SearchRecipesResponse> {
        let baseURL = "https://api.spoonacular.com/recipes/search?"
        let finalURL = URLConfigurator(baseURL: baseURL, query: recipeName, number: number, apiKey: apiKey).buildSearchURL()
        let request = URLRequest(url: finalURL!)
        let recipesResponse: Observable<SearchRecipesResponse> = fetch(request: request) { data in
            do{
                let recipes = try
                    JSONDecoder().decode(SearchRecipesResponse.self, from: data)
                return recipes
            }catch let error {
                print(error)
                return nil
            }
        }
        .asObservable()
        return recipesResponse
     }
     
}
