//
//  RecipeDataManager.swift
//  Meals App
//
//  Created by Сергей on 14.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

enum DataManagerError: Error{
    case notFoundRecipeWithId(id: Int)
}

class RecipeDataManager {
    
    private var context : NSManagedObjectContext!
    private var recipeEntities = [RecipeEntity]()
    
    private func fetchRecipes(predicate: NSPredicate?) {
        context = CoreDataStack().persistentContainer.viewContext
        let request : NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        if predicate != nil {
            request.predicate = predicate
        }
        do{
            let results = try context.fetch(request)
            recipeEntities = results
        }catch{
            print(error)
        }
    }
    
    func toRecipeArray() -> [Recipe] {
        var recipes = [Recipe]()
        fetchRecipes(predicate: nil)
        guard recipeEntities.count != 0 else { return recipes}
        for recipeEntity in recipeEntities {
            recipes.append(toRecipe(recipeEntity))
        }
        return recipes
    }
    
    func getRecipe(withId id: Int) throws -> Recipe {
        let predicate = NSPredicate(format: "id == %d", Int32(id))
        fetchRecipes(predicate: predicate)
        guard recipeEntities.count != 0 else { throw DataManagerError.notFoundRecipeWithId(id: id) }
        
        return toRecipe(recipeEntities.first!)
    }
    
    func toRecipe(_ recipeEntity: RecipeEntity) -> Recipe {
        let ingredientsSet = recipeEntity.ingredients?.allObjects as! [IngredientEntity]
        let savedIngredients = ingredientsSet.map{ $0.toSavedIngredients() }
        let infoSet = recipeEntity.recipeInfo?.array as! [RecipeInfoEntity]
        let recipeInfo = infoSet.map{ $0.toRecipeInfo() }
        let steps = recipeEntity.instructions?.array as! [InstructionEntity]
        let recipeInstruction = [RecipeInstruction(steps: steps.map{$0.toStep()})]
        let recipe = Recipe(id: Int(recipeEntity.id), title: recipeEntity.title!, cuisine: recipeEntity.cuisine, image: recipeEntity.image, information: recipeInfo, savedIngredients: savedIngredients, instruction: recipeInstruction)
        return recipe
    }
    
   
    
    func saveRecipe(recipe: Recipe) -> Observable<Bool> {
        context = CoreDataStack().persistentContainer.viewContext
        let savingRecipe = RecipeEntity(context: context)
        var success = false
        savingRecipe.id = Int32(recipe.id)
        savingRecipe.title = recipe.title
        savingRecipe.cuisine = recipe.cuisine
        
        savingRecipe.instructions = NSOrderedSet(array: recipe.instruction[0].steps.map{$0.toInstructionEntity(context: context)})
        savingRecipe.recipeInfo = NSOrderedSet(array: recipe.information.map{$0.toRecipeInfoEntity(context: context)})
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        queue.async{
            
            group.enter()
            if let data = try? Data(contentsOf: URL(string: recipe.imageURL)!){
                savingRecipe.image = data
                savingRecipe.ingredients = NSSet(array: recipe.ingredients.map{$0.toIngredientEntity(context: self.context)})
                }
            group.leave()
        }
        group.wait()
        
            do{
                try self.context.save()
                success = true
            }catch{
                print(error)
                success = false
            }
        
        
        return Observable.just(success)
    }
 
    
    func deleteRecipe(withId id: Int) {
         let request : NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
               let idPredicate = NSPredicate(format: "id==\(id)")
            request.predicate = idPredicate
        let objects = try! context.fetch(request)
        for obj in objects {
            context.delete(obj)
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension IngredientEntity {
    func toSavedIngredients() -> SavedIngredient{
        return SavedIngredient(name: self.name, image: self.image, amount: self.amount)
    }
}

extension RecipeInfoEntity {
    func toRecipeInfo() -> RecipeInfo{
        return RecipeInfo(title: self.title!, imageName: self.imageName!)
    }
}

extension InstructionEntity {
    func toStep() -> Step{
        return Step(number: Int(self.number), step: self.step!)
    }
}
