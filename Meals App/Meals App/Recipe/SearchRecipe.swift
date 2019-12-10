//
//  SearchRecipe.swift
//  Meals App
//
//  Created by Сергей on 09.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct RecipesResponse : Codable {
    var results : [SearchRecipe]
}

struct SearchRecipe : Codable{
    var id = 0
    var title = ""
    var image = ""
}
