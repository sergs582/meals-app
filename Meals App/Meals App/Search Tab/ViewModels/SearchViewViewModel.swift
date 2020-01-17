//
//  SearchViewViewModel.swift
//  Meals App
//
//  Created by Сергей on 08.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class SearchViewViewModel {
    
    var recentSearch : BehaviorRelay<[String]>
    let recentSearchManager = RecentSearchManager()
    private var userDefaults = UserDefaults.standard

    func updateRecentWith(newQuery query: String) {
        let newQueries = recentSearchManager.addQuery(query)
        recentSearch.accept(newQueries)
    }
    
    func clearRecent() {
        recentSearchManager.clear()
        recentSearch.accept([])
    }
    
    init() {
        let queries = recentSearchManager.getRecentSearchQueries()
        recentSearch = BehaviorRelay<[String]>(value: queries)
    }
}
