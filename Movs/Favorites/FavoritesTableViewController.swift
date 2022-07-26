////
////  FavoritesTableViewController.swift
////  Movs
////
////  Created by Lorhany Moraes on 17/07/22.
////
//
//import UIKit
//
//class FavoritesTableViewController: UITableViewController {
//
//    var favoritedMovies: [FavoritedMovie] = []
//    var emptyFavorites = UILabel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        emptyFavorites.clipsToBounds = true
//        emptyFavorites.textAlignment = .center
//        emptyFavorites.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        emptyFavorites.textColor            = .systemBackground
////        getFavorites()
//        
//    }
//    
//    func getFavorites() {
//
//        PersistenceManager.retrieveFavorites { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let favorites):
//                self.updateUI(with: favorites)
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func configLabel() {
//        emptyFavorites.clipsToBounds = true
//        emptyFavorites.textAlignment = .center
//        emptyFavorites.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        emptyFavorites.textColor            = .systemBackground
//    }
//    
//    func updateUI(with favoritedMovies: [FavoritedMovie]) {
//        if favoritedMovies.isEmpty {
//            emptyFavorites.text = "No Movies?\nSearch and add a new one."
//        } else {
//            self.favoritedMovies = favoritedMovies
//            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//    
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return favoritedMovies.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath) as! FavoriteTableViewCell
//
//        let favoritedMovie = favoritedMovies[indexPath.row]
//        cell.prepareCell(fav: favoritedMovie)
//    
//        return cell
//
//    }
////    
////
////    /*
////    // Override to support conditional editing of the table view.
////    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
////        // Return false if you do not want the specified item to be editable.
////        return true
////    }
////    */
////
////    /*
////    // Override to support editing the table view.
////    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        if editingStyle == .delete {
////            // Delete the row from the data source
////            tableView.deleteRows(at: [indexPath], with: .fade)
////        } else if editingStyle == .insert {
////            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
////        }    
////    }
////    */
////
////    /*
////    // Override to support rearranging the table view.
////    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
////
////    }
////    */
////
////    /*
////    // Override to support conditional rearranging of the table view.
////    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
////        // Return false if you do not want the item to be re-orderable.
////        return true
////    }
////    */
////
////    /*
////    // MARK: - Navigation
////
////    // In a storyboard-based application, you will often want to do a little preparation before navigation
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        // Get the new view controller using segue.destination.
////        // Pass the selected object to the new view controller.
////    }
////    */
//
//}


