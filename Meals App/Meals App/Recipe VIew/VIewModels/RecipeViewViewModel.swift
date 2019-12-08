//
//  RecipeViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class RecipeViewViewModel {
    
    private var recipe = Recipe()
    
    var recipeTitle: String {
        return recipe.title
    }
    var headerImageURL: URL? {
        return URL(string: recipe.imageURL)
    }
    var cuisine: String {
        return recipe.cuisine
    }
    func informationCount() -> Int {
        return recipe.information.count
    }
    var information : [RecipeInfo] {
        return recipe.information
    }
    func ingredientsCount() -> Int {
        return recipe.ingredients.count
    }
    var ingredients : [Ingredient] {
        return recipe.ingredients
    }
    func instructionsCount() -> Int {
        return recipe.information.count
    }
    var instructions : [Int : String] {
        return recipe.instruction
    }
    
    init() {
        recipe = Recipe(title: "Burger", imageURL: "", cuisine: "American", information: [
            RecipeInfo(name: "Gluten free", imageURL: ""),
            RecipeInfo(name: "Shit happens", imageURL: ""),
            RecipeInfo(name: "400cal", imageURL: "")],
        ingredients: [
            Ingredient(name: "banana", imageURL: "", amountInMetric: "5kg", amountInUS: "1.3lb"),
            Ingredient(name: "milk", imageURL: "", amountInMetric: "1l", amountInUS: "2oz"),
            Ingredient(name: "meat", imageURL: "", amountInMetric: "2kg", amountInUS: "0.8lb")],
        instruction: [1 : "Cook sausage in a large nonstick skillet over medium-high heat, stirring until sausage crumbles and is              no longer pink.",
                      2 : "Remove from pan; drain well, pressing between paper towels.",
                      3 : "Unroll dough into a rectangular shape on a lightly greased baking sheet; sprinkle evenly with sausage and cheese. Beginning with 1 long side, roll up, jelly-roll fashion. Turn, seam side down, on baking sheet, and pinch ends to secure filling inside."]   )
    }
    
}
