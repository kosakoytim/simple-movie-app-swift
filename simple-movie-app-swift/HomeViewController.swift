//
//  ViewController.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 21/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, HomeViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var nowPlayingMovieImage: UIImageView!
    @IBOutlet weak var nowPlayingMovieTitle: UILabel!
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    private let homePresenter = HomePresenter(dataMovieManager: DataMovieManager())
    private let reuseIdentifier = "CategoryCell"
    private var homeCategories = [HomeCategory]()
    private var passedMovieDetailId : Int = Int()
    private let c = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        homePresenter.setViewDelegate(homeViewDelegate: self)
        onFirstLaunch()
    }
    
    private func onFirstLaunch() {
        homePresenter.getNowPlayingMovie(query: MovieQuery(api_key: c.SECRET_API_KEY))
        homePresenter.getPopularMovies(query: MovieQuery(api_key: c.SECRET_API_KEY))
        homePresenter.getTopRatedMovies(query: MovieQuery(api_key: c.SECRET_API_KEY))
        homePresenter.getUpcomingMovies(query: MovieQuery(api_key: c.SECRET_API_KEY))
    }
    
    func setNowPlayingSection(movie: Movie) {
        nowPlayingMovieTitle.text = movie.title
        nowPlayingMovieImage.kf.setImage(with: URL(string: movie.backdrop_path))
    }
    
    func addMovieSection(category: Category, movies: [Movie]) {
        homeCategories.append(HomeCategory(category: category, movies: movies))
        categoriesCollectionView.reloadData()
    }
    
    func navigateToMovieDetail(movie: Movie) {
        passedMovieDetailId = movie.id
        self.performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toMovieDetail"){
            let data = segue.destination as! MovieDetailViewController
            data.movieId = passedMovieDetailId
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        
        cell.categoryLabel.text = self.homePresenter.getCategoryTextLabel(category: self.homeCategories[indexPath.item].category)
        cell.setMoviesOfCategory(movieFetched: self.homeCategories[indexPath.item].movies)
        cell.setHomePresenter(passedHomePresenter: self.homePresenter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 225)
    }
}

