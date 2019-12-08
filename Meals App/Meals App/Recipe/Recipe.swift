//
//  Recipe.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct Recipe{
    var title = ""
    var imageURL = ""
    var cuisine = ""
    var information = [RecipeInfo]()
    var ingredients = [Ingredient]()
    var instruction = [Int: String]()
}
