//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Lorhany Moraes on 22/07/22.
//

import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbFavorites: UILabel!
    @IBOutlet weak var ivFavorite: UIImageView!
    @IBOutlet weak var btFavorite: UIButton!
    var favoritedMovies: [MoviesResult] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTextAndImageFor(favorite: MoviesResult) {
        lbFavorites.text = favorite.originalTitle
        if let url = URL(string:favorite.posterUrlString ?? " ") {
            ivFavorite.kf.indicatorType = .activity
            ivFavorite.kf.setImage(with: url)
        } else {
            ivFavorite.image = nil
        }
    }
}
