//
//  SeachViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 20/07/22.
//

import UIKit

class SeachViewController: UIViewController {

    @IBOutlet weak var lbMovieSearch: UITextField!
    @IBOutlet weak var btSearch: UIButton!
    @IBOutlet weak var btPopular: UIButton!
    @IBOutlet weak var btTopRated: UIButton!
    @IBOutlet weak var btNowPlaying: UIButton!
    
    var isUsernameEntered: Bool { return !lbMovieSearch.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGoButton()
        configureNowPlaying()
        configurePopular()
        configureTopRated()
        

        // Do any additional setup after loading the view.
    }
    
    func configureGoButton() {
        btSearch.addTarget(self, action: #selector(pushMovieListVC), for: .touchUpInside)
        
    }
    func configureNowPlaying() {
        btNowPlaying.addTarget(self, action: #selector(pushNowPlayingMoviesVC), for: .touchUpInside)
    }
    
    
    func configurePopular() {
        btPopular.addTarget(self, action: #selector(pushPopularMoviesVC), for: .touchUpInside)
    }
    
    
    func configureTopRated() {
        btTopRated.addTarget(self, action: #selector(pushTopRatedMoviesVC), for: .touchUpInside)
    }
    
    @objc func pushMovieListVC() {
        guard isUsernameEntered else {
            return
        }
                
        let movieListVC = MoviesTableViewController(state: .name(lbMovieSearch.text!))
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    
   @objc func pushNowPlayingMoviesVC() {
        let nowPlayingMoviesVC = MoviesTableViewController(state: .category(.nowPlaying))
        navigationController?.pushViewController(nowPlayingMoviesVC, animated: true)
    }
    
    
    @objc func pushPopularMoviesVC() {
        let popularMoviesVC = MoviesTableViewController(state: .category(.popular))
        navigationController?.pushViewController(popularMoviesVC, animated: true)
    }
    
    
    @objc func pushTopRatedMoviesVC() {
        let topRatedMoviesVC = MoviesTableViewController(state: .category(.topRated))
        navigationController?.pushViewController(topRatedMoviesVC, animated: true)
    }
}

extension SeachViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMovieListVC()
        return true
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


