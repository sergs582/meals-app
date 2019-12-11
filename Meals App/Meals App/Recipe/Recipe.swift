//
//  Recipe.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct RecipeResponse: Decodable {
    var id: Int
    var title: String
    var image: String
    var vegetarian: Bool
    var cuisines: [String]?
    var readyInMinutes: Int
    var pricePerServing: Double
    var extendedIngredients: [Ingredient]
    var analyzedInstructions: [RecipeInstruction]
    
    func toRecipe() -> Recipe {
        var recipe = Recipe()
        recipe.id = self.id
        recipe.title = self.title
        recipe.imageURL = image
        
        var recipeInformation = [RecipeInfo]()
        let isVegetarianTitle = vegetarian ? "Vegetarian" : "Non-Vegetarian"
        recipeInformation.append(RecipeInfo(title: isVegetarianTitle, imageName: "vegitarian"))
        recipeInformation.append(RecipeInfo(title: "\(readyInMinutes)", imageName: "time"))
        recipeInformation.append(RecipeInfo(title: "\(pricePerServing)", imageName: "price"))
        recipeInformation.append(RecipeInfo(title: "\(cuisines?.first ?? "International")", imageName: "cuisine"))
        recipe.information = recipeInformation
        recipe.ingredients = extendedIngredients
        recipe.instruction = analyzedInstructions

        return recipe
    }
}




struct Recipe{
    var id = 0
    var title = ""
    var imageURL = ""
    var cuisine: String?
    var information = [RecipeInfo]()
    var ingredients = [Ingredient]()
    var instruction = [RecipeInstruction]()
}
