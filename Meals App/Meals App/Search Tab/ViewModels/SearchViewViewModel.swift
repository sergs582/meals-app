//
//  SearchViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

class SearchViewViewModel {
    
    var recentSearch : Box<[String]> = Box([])
    private var userDefaults = UserDefaults.standard

    func updateRecent(newQuery query: String) {
        if !recentSearch.value.contains(query) {
        recentSearch.value.insert(query, at: 0)
        
          if recentSearch.value.count >= 4 {
            recentSearch.value.removeLast()
          }
          updateUD()
        }
    }
    
    func updateUD(){
        userDefaults.set(recentSearch.value, forKey: "Recent")
    }
    
    init(){
        recentSearch.value = userDefaults.value(forKey: "Recent") as? [String] ?? []
       
    }
    
}
