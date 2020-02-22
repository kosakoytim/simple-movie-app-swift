//
//  CategoryCollectionViewCell.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var moviePosterCollectionView: UICollectionView!
    @IBOutlet weak var seeAllButton: UIButton!
    
    internal let reuseIdentifierMoviePoster = "MoviePosterCell"
    private var movies = [Movie]()
    private var homePresenter = HomePresenter(dataMovieManager: DataMovieManager())
    
    override func awakeFromNib() {
        moviePosterCollectionView.delegate = self
        moviePosterCollectionView.dataSource = self
    }
    
    func setMoviesOfCategory(movieFetched: [Movie]) {
        movies = movieFetched
        moviePosterCollectionView.reloadData()
    }
    
    func setHomePresenter(passedHomePresenter : HomePresenter) {
        homePresenter = passedHomePresenter
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.homePresenter.navigateToMovieDetail(movie: self.movies[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierMoviePoster, for: indexPath as IndexPath) as! MoviePosterCollectionViewCell
        
        cell.moviePosterImage.image = Tools.shared.setImageFromUrl(self.movies[indexPath.item].poster_path)
        return cell
    }
}
