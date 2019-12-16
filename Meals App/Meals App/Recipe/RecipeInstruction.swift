//
//  RecipeInstruction.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import CoreData
struct RecipeInstruction : Codable {
    var steps : [Step]
    
}

struct Step : Codable {
    var number : Int
    var step : String
    
    func toInstructionEntity(context: NSManagedObjectContext ) -> InstructionEntity {
        let entity = InstructionEntity(context: context)
        entity.number = Int16(self.number)
        entity.step = self.step
        return entity
    }
    
}
