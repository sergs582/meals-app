//
//  Ingredient.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct Ingredient : Codable{
    var name : String
    var image : String
    var measures : Measures
    
    func imageURL() -> URL {
        return URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(image)")!
    }
}

struct Measures : Codable {
    var metric : MetricMeasure
}

struct MetricMeasure : Codable {
    var amount : Double
    var unitShort : String
}
