//
//  Movie.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation

struct Movie {
    let backdrop_path: String
    let genres: Array<String>
    let id: Int
    let overview: String
    let poster_path: String
    let production_companies: Array<ProductionCompanies>
    let release_date: String
    let runtime: Int
    let status: String
    let title: String
    let vote_average: Float
}
