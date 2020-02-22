//
//  HomePresenter.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import Foundation

protocol HomeViewDelegate: class {
    func setNowPlayingSection(movie : Movie)
    func addMovieSection(category: Category, movies: [Movie])
    func navigateToMovieDetail(movie : Movie)
}

class HomePresenter {
    private let dataMovieManager : DataMovieManager
    weak private var homeViewDelegate : HomeViewDelegate?
    
    init(dataMovieManager : DataMovieManager) {
        self.dataMovieManager = dataMovieManager
    }
    
    func setViewDelegate(homeViewDelegate : HomeViewDelegate?) {
        self.homeViewDelegate = homeViewDelegate
    }
    
    func navigateToMovieDetail(movie : Movie) {
        self.homeViewDelegate?.navigateToMovieDetail(movie: movie)
    }
    
    func getCategoryTextLabel(category : Category) -> String {
        switch category {
        case .popular:
            return "Popular Movies"
        case .top_rated:
            return "Top Rated Movies"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
    
    func getNowPlayingMovie(query : MovieQuery) {
        dataMovieManager.getNowPlaying(
            query: query,
            onSuccess: { movie in
                self.homeViewDelegate?.setNowPlayingSection(movie: movie)
            },
            onFailure: {}
        )
    }
    
    func getUpcomingMovies(query : MovieQuery) {
        dataMovieManager.getUpcoming(
            query: query,
            onSuccess: { movies in
                self.homeViewDelegate?.addMovieSection(category: Category.upcoming, movies: movies)
        },
            onFailure: {}
        )
    }
    
    func getTopRatedMovies(query : MovieQuery) {
        dataMovieManager.getTopRated(
            query: query,
            onSuccess: { movies in
                self.homeViewDelegate?.addMovieSection(category: Category.top_rated, movies: movies)
        },
            onFailure: {}
        )
    }
    
    func getPopularMovies(query : MovieQuery) {
        dataMovieManager.getPopular(
            query: query,
            onSuccess: { movies in
                self.homeViewDelegate?.addMovieSection(category: Category.popular, movies: movies)
        },
            onFailure: {}
        )
    }
}
