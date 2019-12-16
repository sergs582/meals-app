//
//  Ingredient.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import CoreData

struct Ingredient : Codable{
    var name : String
    var image : String
    var measures : Measures
   
    func imageURL() -> URL {
        return URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(image)")!
    }
    
    func toIngredientEntity(context: NSManagedObjectContext) -> IngredientEntity {
        let entity = IngredientEntity(context: context)
        entity.amount = "\(self.measures.metric.amount) \(self.measures.metric.unitShort)"
        entity.name = self.name
            if let data = try? Data(contentsOf: self.imageURL()){
                entity.image = data
            }
        return entity
    }
}

struct SavedIngredient{
    var name : String?
    var image : Data?
    var amount : String?
}

struct Measures : Codable {
    var metric : MetricMeasure
}

struct MetricMeasure : Codable {
    var amount : Double
    var unitShort : String
}
