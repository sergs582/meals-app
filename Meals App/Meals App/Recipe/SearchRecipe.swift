//
//  SearchRecipe.swift
//  Meals App
//
//  Created by Сергей on 09.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct SearchRecipesResponse : Codable {
    var results : [SearchRecipe]
}

struct SearchRecipe : Codable{
    var id : Int
    var title : String
    var image : String
    var imageURL : URL? {
        return URL(string: "https://spoonacular.com/recipeImages/\(self.image)")
    }
    
    func toRecipe() -> Recipe{
        return Recipe(id: id, title: title, imageURL: image)
    }
}
