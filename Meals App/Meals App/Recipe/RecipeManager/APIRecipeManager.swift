//
//  APIRecipeManager.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

final class APIRecipeManager: APIManager {
    
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
    
    
}
