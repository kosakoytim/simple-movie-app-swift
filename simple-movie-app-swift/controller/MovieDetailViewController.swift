//
//  MovieDetailViewController.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, MovieDetailDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var movieDetailBackdropImage: UIImageView!
    
    @IBOutlet weak var movieDetailPosterImage: UIImageView!
    
    @IBOutlet weak var movieDetailTitleLabel: UILabel!
    
    @IBOutlet weak var movieDetailRatingLabel: UILabel!
    
    @IBOutlet weak var movieDetailYearGenreLabel: UILabel!
    
    @IBAction func movieDetailBackButtonOnTap(_ sender: UIButton, forEvent event: UIEvent) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var movieDetailRuntimeLabel: UILabel!
    
    @IBOutlet weak var movieDetailProdCompColView: UICollectionView!
    
    @IBOutlet weak var movieDetailOverviewLabel: UILabel!
    
    @IBOutlet weak var movieDetailStatusLabel: UILabel!
    
    @IBOutlet weak var movieDetailReleaseDateLabel: UILabel!
    
    @IBOutlet weak var movieDetailScrollView: UIScrollView!
    
    @IBOutlet weak var movieDetailProdCompCollectionView: UICollectionView!
    
    var movieId : Int = Int()
    private let movieDetailPresenter = MovieDetailPresenter(dataMovieManager: DataMovieManager())
    private let reuseIdentifier = "ProductionCompanyCell"
    private var companyLogoImagePaths = [String]()
    private let c = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        movieDetailPresenter.setViewDelegate(movieDetailDelegate: self)
        movieDetailPresenter.getMovieDetail(query: MovieQuery.Detail(api_key: c.SECRET_API_KEY, id: movieId))
    }
    
    func setMovieDetail(title: String, rating: String, poster: String, backdrop: String, yearAndGenre: String, runtime: String, status: String, releaseDate: String, overview: String, productionCompanyLogo: [String]) {
        self.movieDetailTitleLabel.text = title
        self.movieDetailRatingLabel.text = rating
        self.movieDetailPosterImage.kf.setImage(with: URL(string: poster))
        self.movieDetailBackdropImage.kf.setImage(with: URL(string: backdrop))
        self.movieDetailYearGenreLabel.text = yearAndGenre
        self.movieDetailRuntimeLabel.text = runtime
        self.movieDetailStatusLabel.text = status
        self.movieDetailReleaseDateLabel.text = releaseDate
        self.movieDetailOverviewLabel.text = overview
        self.companyLogoImagePaths = productionCompanyLogo
        self.movieDetailProdCompCollectionView.reloadData()
        
        adjustHeight()
    }
    
    func adjustHeight () {
        self.movieDetailScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(
            UIScreen.main.bounds.height + self.movieDetailOverviewLabel.bounds.height
        ))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.companyLogoImagePaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProductionCompanyCollectionViewCell
        
        cell.productionCompanyLogoImage.kf.setImage(with: URL(string: self.companyLogoImagePaths[indexPath.item]))
        
        return cell
    }
}
