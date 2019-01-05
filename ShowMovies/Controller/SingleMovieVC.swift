//
//  SingleMovieVC.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/5/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class SingleMovieVC: UIViewController {
    var movie = [String:Any]()
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var movieOverview: UITextView!
    @IBOutlet private weak var movieReleaseDateLB: UILabel!
    @IBOutlet private weak var movieVoteAverageLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMovieDetails()

    }
    
    private func showMovieDetails(){
        movieTitle.text = (movie["title"] as! String)
        movieOverview.text = movie["overview"] as! String
        movieReleaseDateLB.text = (movie["release_date"] as! String)
        
        let voteAverage = Int(movie["vote_average"] as! Double)
        movieVoteAverageLB.text = "⭐️\(voteAverage)%"
        
        let posterPath = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + posterPath)
        moviePosterImage.af_setImage(withURL:imageUrl!)
    }
    
    @IBAction private func addToFavoritesB(_ sender: UIButton) {
        let newMovie = Movies(context: context)
        
        let title = movie["title"] as! String
        newMovie.title = title
        
        let overview = movie["overview"] as! String
        newMovie.overview = overview
        
        let posterPath = movie["poster_path"] as! String
        newMovie.posterImage = posterPath
        
        do {
            ad.saveContext()
        } catch{
            print("Can't save item")
        }
 
    }
    

    
}
