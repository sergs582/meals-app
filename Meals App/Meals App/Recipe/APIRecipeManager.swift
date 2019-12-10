//
//  APIRecipeManager.swift
//  Meals App
//
//  Created by Сергей on 09.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

final class APIRecipeManager : APIManager {
   
    
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
    
    func fetchRecipeWith(recipeName: String, number: Int, completion: @escaping (APIResult<RecipesResponse>) -> Void) {
        let baseURL = "https://api.spoonacular.com/recipes/search?"
        let finalURL = URLConfigurator(baseURL: baseURL, query: recipeName, number: number, apiKey: apiKey).buildURL()
        let request = URLRequest(url: finalURL!)
        
        fetch(request: request, decode: { (data) -> RecipesResponse? in
            do{
                let recipes = try JSONDecoder().decode(RecipesResponse.self, from: data)
                return recipes
            }catch let error {
                print(error)
                return nil
            }
        }, completion: completion)
    }
    
}
