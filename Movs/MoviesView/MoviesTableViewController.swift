//
//  MoviesTableViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 07/07/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class MoviesTableViewController: UITableViewController {
    
    var moviesInfo: [MoviesResult] = []
    var infoMovie = [MoviesResult]()
    var allMovies: APIMovies?
    var currentPage = 1
    var limit = 20
    var offset = 0
    var total = 0
    var loadingMovies = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies() {
        loadingMovies = true
        MovieAPI.loadAllMovie(page: currentPage, onComplete: { (movies) in
            if let movies = movies {
                self.allMovies = movies
                self.moviesInfo += movies.results ?? []
                self.currentPage = (self.allMovies?.page ?? 0) + 1
                self.loadingMovies = false
                self.tableView.reloadData()
            }
            
        })  { (error) in
            switch error {
            case .invalidJSON:
                print("JSON Inválido")
            default:
                print(error)
                
            }
        }
    }    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DescriptionTableViewCell
        
        let movie = (moviesInfo[indexPath.row])
        
        cell.prepareCell(with: movie)
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ResultViewController else {return}
        let movies = moviesInfo[tableView.indexPathForSelectedRow!.row]
        viewController.infoMovies = movies
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !loadingMovies{
                loadingMovies = true
                self.currentPage = self.currentPage+1
                self.limit = self.limit + 10
                self.offset = self.limit * self.currentPage
                self.loadMovies()
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            spinner.color = .white
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.tabBarController?.tabBar.isHidden = true
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.tabBarController?.tabBar.isHidden = false
                print("Unhide")
            }, completion: nil)
        }
        
    }
}
