//
//  ViewController.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 21/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    @IBOutlet weak var nowPlayingMovieImage: UIImageView!
    @IBOutlet weak var nowPlayingMovieTitle: UILabel!
    
    private let homePresenter = HomePresenter(dataMovieManager: DataMovieManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter.setViewDelegate(homeViewDelegate: self)
        onFirstLaunch()
    }
    
    private func onFirstLaunch() {
        homePresenter.getNowPlayingMovie(query:
            MovieQuery(api_key: "4fec1de9e64760cc69913fd294b9ec82")
        )
    }
    
    func setNowPlayingSection(movie: Movie) {
        nowPlayingMovieTitle.text = movie.title
        nowPlayingMovieImage.image = Tools.shared.setImageFromUrl(movie.backdrop_path)
    }


}

