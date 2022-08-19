//
//  FavDescriptionViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 01/08/22.
//

//import UIKit
//
//class FavDescriptionViewController: UIViewController {
//    
//    
//    @IBOutlet weak var ivBackDropFav: UIImageView!
//    @IBOutlet weak var ivPosterPathFav: UIImageView!
//    @IBOutlet weak var lbTitleFav: UILabel!
//    @IBOutlet weak var lbGenreFav: UILabel!
//    @IBOutlet weak var lbYearFav: UILabel!
//    @IBOutlet weak var lbOverviewFav: UILabel!
//    
//    var infoMovies: MoviesResult?
//    var favoritedMovie: FavoritedMovie?
////    var genreIds: GenreModel?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewFavorites()
//    }
//    
////    var genres: String {
////        guard let genreIds = infoMovies?.genreIds else {
////            return " "
////        }
////
////        let genreNames = genreIds.compactMap {
////            MovieGenres(rawValue: $0)?.description
////        }
////
////        return genreNames.joined(separator: ", ")
////    }
//    
//    func viewFavorites() {
//        
//        lbTitleFav.text = infoMovies?.originalTitle ?? " "
//        lbYearFav.text = infoMovies?.releaseYear ?? " "
//        lbOverviewFav.text = infoMovies?.overview
////        lbGenreFav.text = genreIds?.name
//        if let urlPoster = URL(string: infoMovies?.backUrlString ?? " ") {
//            ivBackDropFav.kf.indicatorType = .activity
//            ivBackDropFav.kf.setImage(with: urlPoster)
//        } else {
//            ivBackDropFav.image = nil
//        }
//        
//        ivPosterPathFav.layer.cornerRadius = 15
//       
//        if let url = URL(string: infoMovies?.posterUrlString ?? "") {
//             ivPosterPathFav.kf.indicatorType = .activity
//             ivPosterPathFav.kf.setImage(with: url)
//          } else {
//               ivPosterPathFav.image = nil
//          }
//        
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
