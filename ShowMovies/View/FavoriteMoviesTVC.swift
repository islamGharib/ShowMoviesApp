//
//  FavoriteMoviesTVC.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/5/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit
/*
 this view cell displays only the favorite movies for the user
 it contains lable for displaying movie title , lable for displaying the description and
 image view for displaying the movie poster
 */
class FavoriteMoviesTVC: UITableViewCell {
    @IBOutlet weak var movieTitleLB: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieOverviewTV: UITextView!
    @IBOutlet weak var deleteB: UIButton!
    
}
