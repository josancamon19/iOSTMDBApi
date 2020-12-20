//
//  MovieViewCell.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 13/12/20.
//

import UIKit
import SDWebImage

class MovieViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMovieData(movie:Movie){
        movieImage.sd_setImage(with: URL(string: getPosterURL(imagePath: movie.imagePath)), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
}
