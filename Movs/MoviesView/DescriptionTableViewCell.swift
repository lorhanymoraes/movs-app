//
//  DescriptionTableViewCell.swift
//  Movs
//
//  Created by Lorhany Moraes on 12/07/22.
//

import UIKit
import Kingfisher

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    public static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
        
    
    func prepareCell(with movie: MoviesResult) {
        lbTitle.text = movie.originalTitle
        lbYear.text = movie.releaseYear
        lbDescription.text = movie.overview
        
        ivMovie.layer.cornerRadius = 20
        if let url = URL(string: movie.posterUrlString!) {
         ivMovie.kf.indicatorType = .activity
         ivMovie.kf.setImage(with: url)
      } else {
           ivMovie.image = nil
      }
    }
    
}

