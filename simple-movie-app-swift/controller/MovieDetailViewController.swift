//
//  MovieDetailViewController.swift
//  simple-movie-app-swift
//
//  Created by Macbook on 22/02/20.
//  Copyright © 2020 Hackington. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDetailBackdropImage: UIImageView!
    
    @IBOutlet weak var movieDetailPosterImage: UIImageView!
    
    @IBOutlet weak var movieDetailTitleLabel: UILabel!
    
    @IBOutlet weak var movieDetailRatingLabel: UILabel!
    
    @IBOutlet weak var movieDetailYearGenreLabel: UILabel!
    
    @IBOutlet weak var movieDetailRuntimeLabel: UILabel!
    
    @IBOutlet weak var movieDetailDirectorLabel: UILabel!
    
    @IBOutlet weak var movieDetailProdCompColView: UICollectionView!
    
    @IBOutlet weak var movieDetailOverviewLabel: UILabel!
    
    @IBOutlet weak var movieDetailStatusLabel: UILabel!
    
    @IBOutlet weak var movieDetailReleaseDateLabel: UILabel!
    
    @IBOutlet weak var movieDetailBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
