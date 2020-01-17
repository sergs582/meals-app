//
//  DataManager.swift
//  Meals App
//
//  Created by Сергей on 16.01.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import Foundation
import RxSwift

protocol DataManager {
    func getRecipe(withID id: Int) -> Single<Recipe>
}

protocol SearchDataManager {
    func getRecipes(withName name: String) -> Observable<SearchRecipesResponse>
}
