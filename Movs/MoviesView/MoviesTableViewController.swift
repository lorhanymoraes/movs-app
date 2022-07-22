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
    
    var allMovies: APIMovies?
    var currentPage = 1
    var total = 0
    var loadingMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }


        func loadMovies() {
        loadingMovies = true
        Configuration.loadMovie(page: currentPage, onComplete: { (movies) in
            self.allMovies = movies
            if let movies = movies {
                self.total = movies.totalResults
            }
        
            DispatchQueue.main.async {
                self.loadingMovies = false
                self.tableView.reloadData()
            }

            
        })  { (error) in
            switch error {
            case .decodeError:
                print("JSON Inválido")
            default:
                print(error)
        
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        viewController.infoMovies = allMovies?.results?[tableView.indexPathForSelectedRow!.row]
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies?.results?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DescriptionTableViewCell
        
        let movie = (allMovies?.results?[indexPath.row])!
        
        cell.prepareCell(with: movie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == allMovies!.results!.count - 1 && !loadingMovies && allMovies?.results?.count != total {
            currentPage += 1
            loadMovies()
            print("Loading more movies")
        }
    }
}
    
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

