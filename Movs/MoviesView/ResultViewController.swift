//
//  ResultViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 13/07/22.
//

import UIKit
import Kingfisher
import SwiftUI

protocol FavoriteDelegate: AnyObject {

}

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
    var genre: GenreJSON?
    
    var formattedReleaseDate: Date? {
        if let releaseDate = infoMovies?.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            return dateFormatter.date(from: releaseDate)
        }
        return nil
    }


                                                    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()


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
   

    
    @IBAction func selectButton(_ sender: UIButton) {
        
        let image = UIImage(systemName: "bolt.heart.fill")
        sender.setImage(image, for: .normal)
        
       
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
