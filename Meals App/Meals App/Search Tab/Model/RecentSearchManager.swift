//
//  RecentSearchManager.swift
//  Meals App
//
//  Created by Сергей on 15.01.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import Foundation
import RxSwift

class RecentSearchManager{
    
    private let key = "Recent"
    private let ud = UserDefaults.standard
    func getRecentSearchQueries() -> [String] {
        let queries = self.ud.value(forKey: self.key) as? [String] ?? []
        return queries
    }
    
    func clear() {
        ud.set([String](), forKey: key)
    }
    
    func addQuery(_ query: String) -> [String] {
        var queries = ud.value(forKey: key) as? [String] ?? []
        if !queries.contains(query){
            queries.insert(query, at: 0)
            if queries.count > 4 {
                queries.removeLast()
            }
            ud.set(queries, forKey: key)
        }
        return queries
    }
    
}
