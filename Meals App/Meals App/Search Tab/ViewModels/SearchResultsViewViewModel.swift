//
//  SearchResultsViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift

class SearchResultsViewViewModel {
    
    var recipes : Observable<[SearchRecipe]>!
    var newItems : [SearchRecipe]?
    var fetchingMore = false
   
    var searchQuery : Box<String?> = Box(nil)

    var searchRecipeManager = APIRecipeManager(apiKey: "b9b785cbea634d2c82b2b9855cf33756")

    func fetchResults(query: String, number: Int) -> Observable<[SearchRecipe]> {
        return searchRecipeManager.fetchRecipeWith(recipeName: query, number: number)
                .map{ $0.results }
    }
    
}
