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
    
    func getNowPlayingMovie(query : MovieQuery) {
        dataMovieManager.getNowPlaying(
            query: query,
            onSuccess: { movie in
                self.homeViewDelegate?.setNowPlayingSection(movie: movie)
            },
            onFailure: {}
        )
    }
}
