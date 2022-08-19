//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Lorhany Moraes on 22/07/22.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    
    var favoritedMovies: [FavoritedMovie] = []
    var favoritesMovie = [FavoritedMovie]()
    var movieId: Int?
    var infoMovies: MoviesResult?
    var allMovies: APIMovies?
    var lbNoFavorites: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelNoFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        tableView.reloadData()
        
    }
    
    
    func labelNoFavorites() {
        lbNoFavorites = UILabel()
        lbNoFavorites?.text = "No Movies?\nSearch and add a new one"
        lbNoFavorites?.textAlignment = .center
        lbNoFavorites?.adjustsFontSizeToFitWidth = true
        lbNoFavorites?.numberOfLines = 0
        lbNoFavorites?.textColor = .white
    }
    
    func getFavorites() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    func updateUI(with favoritedMovies: [FavoritedMovie]) {
        if favoritedMovies.isEmpty { return
        } else {
            self.favoritedMovies = favoritedMovies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func btUnfavorite(_ sender: UIButton) {
        
        
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else {return}
        
        PersistenceManager.updateWith(favoritedMovie: favoritedMovies[indexPath.row], actionType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            
            guard error != nil else {
                self.favoritedMovies.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
                self.tableView.reloadData()
                return
                
            }
            
        }
    }
    

    // MARK: - Table view data source

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueFavorites" {
//            let viewController = segue.destination as? ResultViewController
//            viewController?.infoMovies? = (allMovies?.results?[tableView.indexPathForSelectedRow?.row ?? 0])!
//        }
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritedMovies.count > 0 {
            return favoritedMovies.count
        } else {
            tableView.backgroundView = lbNoFavorites
        }
        return favoritedMovies.count
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoritedMovie = favoritedMovies[indexPath.row]
        let destinationView = ResultViewController()
        destinationView.infoMovies?.id = favoritedMovie.id
        let navigationController = UINavigationController(rootViewController: destinationView)
        present(navigationController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell

        let favoritedMovie = favoritedMovies[indexPath.row]
        cell.setTextAndImageFor(favorite: favoritedMovie)
        
        return cell
    }
    

    

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        guard editingStyle == .delete else { return }
////
//        PersistenceManager.updateWith(favoritedMovie: favoritedMovies[indexPath.row], actionType: .remove) { [weak self] error in
//
//            guard let self = self else { return }
//
//            guard error != nil else {
//                self.favoritedMovies.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .left)
//                return
//
//            }
//
//        }
//    }

   
}

