//
//  HomeCategory.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation

enum Category {
    case upcoming
    case top_rated
    case popular
}

struct HomeCategory {
    let category : Category
    let movies : [Movie]
}
