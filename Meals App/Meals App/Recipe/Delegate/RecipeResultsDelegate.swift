//
//  SearchResultsDelegate.swift
//  Fridgy Recipes
//
//  Created by Сергей on 01.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import UIKit


//To be implemented by Tables with Recipe Results (ex.: FavouriteVC, SearchVC)
protocol RecipeResultsDelegate: class {
    func didSelectResult(recipe: Recipe)
}
