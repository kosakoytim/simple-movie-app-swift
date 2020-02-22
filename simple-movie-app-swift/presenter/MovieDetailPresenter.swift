//
//  MovieDetailPresenter.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation

protocol MovieDetailDelegate : class {
    func setMovieDetail(
        title: String,
        rating: String,
        poster: String,
        backdrop: String,
        yearAndGenre: String,
        runtime: String,
        status: String,
        releaseDate: String,
        overview: String,
        productionCompanyLogo: [String]
    )
}

class MovieDetailPresenter {
    private let dataMovieManager : DataMovieManager
    weak private var movieDetailDelegate : MovieDetailDelegate?
    
    init(dataMovieManager : DataMovieManager) {
        self.dataMovieManager = dataMovieManager
    }
    
    func setViewDelegate(movieDetailDelegate : MovieDetailDelegate?) {
        self.movieDetailDelegate = movieDetailDelegate
    }
    
    private func getYearAndGenre(release_date: String, genres: [String]) -> String {
        var releaseDateSplit = release_date.split(separator: "-")
        let firstGenre = genres[0]
        return releaseDateSplit[0] + " - " + firstGenre
    }
    
    private func getHourMinuteRuntime(runtime: Int) -> String {
        if (runtime >= 60) {
            var hour = 1
            var tmp = 60
            while tmp < runtime {
                tmp+=60
                if (tmp < runtime) {
                    hour+=1
                }
            }
            let minute = runtime - (hour * 60)
            return String(hour) + " hour " + String(minute) + " min"
        } else {
            return String(runtime) + " min"
        }
    }
    
    private func getProductionCompaniesLogoPath(productionCompanies : [ProductionCompanies]) -> [String] {
        var strings = [String]()
        for i in productionCompanies {
            strings.append(i.logo_path)
        }
        return strings
    }
    
    func getMovieDetail(query : MovieQuery.Detail) {
        dataMovieManager.getMovieDetail(
            query: query,
            onSuccess: { movie in
                self.movieDetailDelegate?.setMovieDetail(
                    title: movie.title,
                    rating: String(movie.vote_average),
                    poster: movie.poster_path,
                    backdrop: movie.backdrop_path,
                    yearAndGenre: self.getYearAndGenre(release_date: movie.release_date, genres: movie.genres),
                    runtime: self.getHourMinuteRuntime(runtime: movie.runtime),
                    status: movie.status,
                    releaseDate: movie.release_date,
                    overview: movie.overview,
                    productionCompanyLogo: self.getProductionCompaniesLogoPath(productionCompanies: movie.production_companies)
                )
            },
            onFailure: {})
    }
}
