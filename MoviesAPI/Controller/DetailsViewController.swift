//
//  DetailsViewController.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 17/12/20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailTitle: UILabel!
    @IBOutlet weak var movieDetailVotes: UILabel!
    @IBOutlet weak var movieDetailOverview: UILabel!
    
    @IBOutlet weak var movieDetailReleaseDate: UILabel!
    var movie : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailTitle.text = movie.title
        movieDetailImage.sd_setImage(with: URL(string: getPosterURL(imagePath: movie.imagePath)), placeholderImage: UIImage(named: "placeholder.png"))
        movieDetailVotes.text = "\(movie.votes) ⭐️"
        movieDetailOverview.text = movie.overview
        movieDetailReleaseDate.text = movie.releaseDate
        
    }
    
    func setMovieData(movie:Movie) {
        self.movie = movie
    }
}
