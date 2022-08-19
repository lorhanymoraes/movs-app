//
//  ResultViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 13/07/22.
//

import UIKit
import Kingfisher
import SwiftUI


class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var ivMovies: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbReleaseYear: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbMovieDescription: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var favorite: UIButton!
    @IBOutlet weak var ivBackdrop: UIImageView!
    
    
    var movies: APIMovies?
    var infoMovies: MoviesResult?
    var movieID: Int?
    var favMovie: FavoritedMovie?
    var favoritesMovie = [FavoritedMovie]()
    var isMovieFav = UserDefaults.standard.bool(forKey: "favorites2")
    var favoritedMovie: [FavoritedMovie] = []
    var movieApi: MovieAPI?
    var allGenres: GenresResponse?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        loading.startAnimating()
        viewConfiguration()
        getFavorites()
        changeButton()
        getGenre()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButton()
    }
    
    func viewConfiguration() {
        lbMovieTitle.text = infoMovies?.originalTitle ?? " "
        lbReleaseYear.text = infoMovies?.releaseYear ?? " "
        lbMovieDescription.text = infoMovies?.overview
//        lbGenre.text = allGenres?.name ?? "n/a"
        
        if let urlPoster = URL(string: infoMovies?.backUrlString ?? " ") {
            ivBackdrop.kf.indicatorType = .activity
            ivBackdrop.kf.setImage(with: urlPoster)
        } else {
            ivBackdrop.image = nil
        }
        
        ivMovies.layer.cornerRadius = 15
        
        if let url = URL(string: infoMovies?.posterUrlString ?? "") {
            ivMovies.kf.indicatorType = .activity
            ivMovies.kf.setImage(with: url)
        } else {
            ivMovies.image = nil
        }
        loading.stopAnimating()
    }
    
    func getGenre(){
        MovieAPI.getGenres (onComplete: { (genres) in
            if let genres = self.allGenres?.genres {
                self.lbGenre.text = genres.map({ $0.name }).joined(separator: ", ")
            } else {
                self.lbGenre.text = "N/A"
            }
        }) { (error) in
            switch error {
            case .noResponse:
                print("\(ModelError.noResponse)")
            default:
                print(error)
                
            }
        }
    }
    
//    func getMovieGenre() {
//        MovieAPI.loadInfoMovie(movieID: movieID ?? 0, onComplete:  { (movie) in
//            let movie = self.infoMovies
//            if let genres = movie?.genres, genres.count > 0 {
//                self.lbGenre.text = genres.map({$0.name}).joined(separator: ", ")
//            } else {
//                self.lbGenre.text = "N/A"
//            }
//        }) { (error) in
//            switch error {
//            case .noResponse:
//                print("\(ModelError.noResponse)")
//            default:
//                print(error)
//
//            }
//        }
//    }
    
    
    @IBAction func selectButton(_ sender: UIButton) {
        
        MovieAPI.loadInfoMovie(movieID: infoMovies?.id ?? 0, onComplete: { (movie) in
            if let movie = movie {
                
                dump(movie)
                self.addMovieToFavorites(with: movie)
                self.favorite.setImage(UIImage(systemName: "bolt.heart.fill"), for: .normal)
            }
            
        })  { (error) in
            switch error {
            case .unableToFavorite:
                print("\(ModelError.unableToFavorite)")
            default:
                print(error)
                
            }
        }
    }
    
    func getFavorites() {

        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favoritesMovie = favorites
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func isMovieFavorited() -> Bool {
        favoritesMovie.contains { favorito in
            favorito.id == infoMovies?.id
        }
    }
    
    
    func changeButton() {
        if isMovieFavorited() {
            favorite.setImage(UIImage(systemName: "bolt.heart.fill"), for: .normal)
        } else {
            return
        }
    }
    
    
    func addMovieToFavorites(with movie: MoviesResult) {
        
        let favoritedMovie = FavoritedMovie(id: movie.id, title: movie.originalTitle, posterPath: movie.posterUrlString)
        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard error != nil else {
                return
            }
            
        }
    }

}
