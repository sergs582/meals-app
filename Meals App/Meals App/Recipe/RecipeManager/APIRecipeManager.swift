//
//  APIRecipeManager.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift


protocol ApiRecipeManagerProtocol {
    func fetchRecipeWith(recipeId: Int) -> Single<Recipe>
    func fetchRecipeWith(recipeName: String, number: Int) -> Observable<SearchRecipesResponse>
}


enum APIError: Error {
    case URLCreationError
    case parsingError
    case decodingError
}

final class APIRecipeManager: ApiRecipeManagerProtocol {

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
    
    private func fetchData(_ request: URLRequest) -> Observable<Data> {
        return URLSession.shared
            .rx.data(request: request)
    }
    
    func parseJSON<T: Decodable>(_ data: Data) throws -> T {
        guard  let recipes = try? JSONDecoder().decode(T.self, from: data) else{
            throw APIError.decodingError
        }
        return recipes
    }
    
    func fetchRecipeWith(recipeId: Int) -> Single<Recipe> {
       let baseURL = "https://api.spoonacular.com/recipes/"
       let finalURL = URLConfigurator(baseURL: baseURL,  apiKey: apiKey, recipeId: recipeId).buildRecipeURL()
       let request = URLRequest(url: finalURL!)
       return fetchData(request)
            .map { data in
                let recipe : RecipeResponse
                recipe = try self.parseJSON(data)
                return recipe.toRecipe()
            }
            .asSingle()
    }
    
    
    func fetchRecipeWith(recipeName: String, number: Int) -> Observable<SearchRecipesResponse> {
       let baseURL = "https://api.spoonacular.com/recipes/search?"
       let finalURL = URLConfigurator(baseURL: baseURL, query: recipeName, number: number, apiKey: apiKey).buildSearchURL()
       let request = URLRequest(url: finalURL!)
        return fetchData(request)
            .map{
                data in
                let searchRecipe : SearchRecipesResponse = try self.parseJSON(data)
                return searchRecipe
        }
    }
}


