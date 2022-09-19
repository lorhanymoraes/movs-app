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
    
    var infoMovies: MoviesResult?
    var movieID: Int!
    var favoritesMovie = [MoviesResult]()
    var isMovieFav = UserDefaults.standard.bool(forKey: "favorites2")
    var allGenres: GenresResponse?
    var idGenre: [Genre] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
        getFavorites()
        changeButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButton()
        getGenre()
    }
    
    func viewConfiguration() {
        lbMovieTitle.text = infoMovies?.originalTitle ?? " "
        lbReleaseYear.text = infoMovies?.releaseYear ?? " "
        lbMovieDescription.text = infoMovies?.overview
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
    
    func getGenre() {
        MovieAPI.getGenres (onComplete: { (genres) in
            self.allGenres = genres
            self.filterGenres()
        }) { (error) in
            switch error {
            case .noResponse:
                print("\(ModelError.noResponse)")
            default:
                print(error)
            }
        }
    }
    
    func filterGenres() {
        let genresIds = infoMovies?.genreIds
        
        let genres = self.allGenres?.genres.filter({ genre in
            genresIds?.contains(genre.id) ?? false
        })
        
        let genresName = genres?.map({ genre in
            genre.name
        })
        
        self.lbGenre.text = genresName?.joined(separator: ", ")
    }
    
    
    
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
        
        let favoritedMovie = MoviesResult(posterPath: movie.posterPath, adult: movie.adult, overview: movie.overview, releaseDate: movie.releaseDate, genreIds: infoMovies?.genreIds, id: movie.id, originalTitle: movie.originalTitle, originalLanguage: movie.originalTitle, title: movie.title, backdropPath: movie.backdropPath, popularity: movie.popularity, voteCount: movie.voteCount, video: movie.video, voteAvarage: movie.voteAvarage)

        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovie, actionType: .add) { [weak self] error in
            guard self != nil else { return }
            
            guard error != nil else {
                return
            }
            
        }
    }

}
