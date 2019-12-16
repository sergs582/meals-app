//
//  HeaderViewDelegate.swift
//  Meals App
//
//  Created by Сергей on 15.12.2019.
//  Copyright © 2019 Сергей. All rights reserved.
//

import Foundation

protocol HeaderViewDelegate: class {
    func addToFavourite()
    func addLoadedData(data : Data)
}
