//
//  URLConfigurator.swift
//  Meals App
//
//  Created by Сергей on 10.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

struct URLConfigurator {
    var baseURL: String
    var query: String
    var number: Int = 1
    var apiKey: String!
    
    func buildURL() -> URL? {
        var URLString = baseURL
        URLString.append(contentsOf: "query=\(query)&")
        URLString.append(contentsOf: "number=\(number)&")
        URLString.append(contentsOf: "apiKey=\(apiKey ?? "")")
        return URL(string: URLString)
    }
}
