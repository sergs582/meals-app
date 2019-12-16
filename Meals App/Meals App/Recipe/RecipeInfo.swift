//
//  RecipeInfo.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import CoreData
struct RecipeInfo {
    var title : String
    var imageName : String
    
    func toRecipeInfoEntity(context: NSManagedObjectContext) -> RecipeInfoEntity {
        let entity = RecipeInfoEntity(context: context)
        entity.imageName = self.imageName
        entity.title = self.title
        return entity
    }
}
