//
//  Movie.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation

struct Movie : Base {
    let id: Int
    let title: String
    let poster_path: String
    let backdrop_path: String
}

private protocol Base {
    var id: Int { get }
    var title: String { get }
    var poster_path: String { get }
    var backdrop_path: String { get }
}

private protocol DetailDisplay {
    var overview: String { get }
    var genres: [String] { get }
    var production_companies: [ProductionCompanies] { get }
    var release_date: String { get }
    var runtime: Int { get }
    var status: String { get }
    var vote_average: Float { get }
}

extension Movie {
    struct Detail : Base, DetailDisplay {
        var id: Int
        var title: String
        var poster_path: String
        var backdrop_path: String
        var overview: String
        var genres: [String]
        var production_companies: [ProductionCompanies]
        var release_date: String
        var runtime: Int
        var status: String
        var vote_average: Float
    }
}

struct MovieQuery : BaseQuery {
    let api_key: String
}

private protocol BaseQuery {
    var api_key: String { get }
}

private protocol DetailQuery {
    var id: Int { get }
}

extension MovieQuery {
    struct Detail : BaseQuery, DetailQuery {
        var api_key: String
        var id: Int
    }
}
