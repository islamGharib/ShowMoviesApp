//
//  MovieTVC.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/4/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit
/*
   this view cell displays all movies
   it contains lable for displaying movie title , lable for displaying the description and
   image view for displaying the movie poster
 */
class MovieTVC: UITableViewCell {
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLB: UILabel!
    @IBOutlet weak var movieOverviewTV: UITextView!
    
    

}
