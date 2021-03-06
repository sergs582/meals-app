//
//  APIManager.swift
//  Meals App
//
//  Created by Сергей on 09.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation
import RxSwift

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration : URLSessionConfiguration { get }
    var session : URLSession { get }
    
    func JSONTaskWith(request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, decode: @escaping (Data) -> T?, completion: @escaping (APIResult<T>) -> Void)
    func fetch<T>(request: URLRequest, decode: @escaping (Data) -> T?) -> Single<T>
    
    func fetchRecipeWith(recipeId: Int, completion: @escaping (APIResult<RecipeResponse>) -> Void)
    func fetchRecipeWith(recipeName: String, number: Int, completion: @escaping (APIResult<SearchRecipesResponse>) -> Void)
}

extension APIManager {
    func JSONTaskWith(request: URLRequest, completion: @escaping JSONCompletionHandler) -> JSONTask {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: MLSNetworkingErrorDomain, code: 100, userInfo: userInfo)
                completion(nil, nil, error)
                return
            }
            if data == nil{
                if let error = error{
                    completion(nil, HTTPResponse, error)
                }
            }else {
                    switch HTTPResponse.statusCode{
                    case 200:
                            completion(data, HTTPResponse, nil)
                    default:
                        print("Response Status: \(HTTPResponse.statusCode)")
                    }
                }
            }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, decode: @escaping (Data) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        let dataTask = JSONTaskWith(request: request) { (data, response, error) in

            guard let data = data else {
                if let error = error{
                    completion(.Failure(error))
                }
                return
            }
            if let value = decode(data) {
                completion(.Success(value))
            } else {
                let error = NSError(domain: MLSNetworkingErrorDomain, code: 200, userInfo: nil)
                completion(.Failure(error))
            }
        }
        dataTask.resume()
    }
    
    func fetch<T>(request: URLRequest, decode: @escaping (Data) -> T?) -> Single<T> {
        return Single<T>.create{ single in
            let dataTask = self.JSONTaskWith(request: request) {
                (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        single(.error(error))
                    }
                    return
                }
                if let value = decode(data) {
                    single(.success(value))
                }else {
                    let error = NSError(domain: MLSNetworkingErrorDomain, code: 200, userInfo: nil)
                    single(.error(error))
                }
            }
            dataTask.resume()
            return Disposables.create{
                dataTask.cancel()
            }
        }
    }
    
}
