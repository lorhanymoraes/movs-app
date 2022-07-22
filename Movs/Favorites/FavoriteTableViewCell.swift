//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by Lorhany Moraes on 17/07/22.
//
//
//import UIKit
//import Kingfisher
//
//class FavoriteTableViewCell: UITableViewCell {
//    
// //   let config = Favorites.shared
//
//    @IBOutlet weak var ivFavorite: UIImageView!
//    @IBOutlet weak var lbFavoriteTitle: UILabel!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//    
//   func prepareCell(fav: FavoritedMovie) {
//       lbFavoriteTitle.text = fav.title
//        
//       if let url = URL(string: fav.posterPath!) {
//         ivFavorite.kf.indicatorType = .activity
//         ivFavorite.kf.setImage(with: url)
//      } else {
//           ivFavorite.image = nil
//      }
//}
//}
