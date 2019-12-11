//
//  RecipeInstruction.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct RecipeInstruction : Codable {
    var steps : [Step]
    
}

struct Step : Codable {
    var number : Int
    var step : String
}
