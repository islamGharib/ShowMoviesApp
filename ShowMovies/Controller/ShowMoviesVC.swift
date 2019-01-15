//
//  ShowMoviesVC.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/3/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
/*
 this view controller responsible for get the data from the api of the server moviedb,
 displaying all movies onto the movieTVC and handling the search operation to help user to find specif movie
 */
class ShowMoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // searchbar outlet
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var moviesTableView: UITableView!
    // array for storing all movies getting from AllMoviesGet object model
    private var movies = [AllMoviesGet]()
    // array contain only the searching result for user
    private var searchMovies = [AllMoviesGet]()
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        searchBar.delegate = self
        
        // get all movies from the server
        fetchMovies()
        
    }
    
    // mark-> handle the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies.removeAll()
        if searchText.isEmpty{
            searching = false
            fetchMovies()
        }else{
                for movie in movies{
                    let title = movie.title
                    if title.lowercased().prefix(searchText.count) == searchText.lowercased(){
                        searchMovies.append(movie)
                    }
                }
                searching = true
                moviesTableView.reloadData()
        }
    }
    // handle the cancel button of the search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        moviesTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchMovies.count
        }else{
            return movies.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieTVC = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTVC
        
        var results = [AllMoviesGet]()
        // display the movies on the cell view
        if searching{
            results = searchMovies
        }else{
            results = movies
        }
            cell.movieTitleLB.text = results[indexPath.row].title
            cell.movieOverviewTV.text = results[indexPath.row].overview
            
            let posterPath = results[indexPath.row].poster_path
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseUrl + posterPath)
            cell.moviePosterImage.af_setImage(withURL:imageUrl!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "oneMovieSeg", sender: movies[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "oneMovieSeg"{
            if let dist = segue.destination as? SingleMovieVC{
                dist.movie = (sender as! AllMoviesGet)
            }
        }
    }
    
    // get all movies from the server then store them to the movies array
    private func fetchMovies(){
        let apiKey = "c8e63d4a4435054c70c1955bf7693cb8"
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")else{return}
        
        // using Alamofire to request api
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                let dataResponse = response.result.value as! [String:Any]
                DispatchQueue.main.async {
                    let results:Array<[String:Any]> = dataResponse["results"] as! Array<[String:Any]>
                    // store the result of the api into the data model
                    for movie in results{
                        let movieTitle = movie["title"] as! String
                        let movieOverview = movie["overview"] as! String
                        let moviePosterImage = movie["poster_path"] as! String
                        let movieVoteAverage = movie["vote_average"] as! Double
                        let movieReleaseDate = movie["release_date"] as! String
                        
                        self.movies.append(AllMoviesGet(vote_count: 0, id: 0, video: false, vote_average: movieVoteAverage, title: movieTitle, popularity: 1.0, poster_path: moviePosterImage, original_language: "en", original_title: "", genre_ids: [], backdrop_path: "", adult: false, overview: movieOverview, release_date: movieReleaseDate))
                    }
                    
                    self.moviesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
        
        /*      make a request using dataTask
        URLSession.shared.dataTask(with: url){(data, success, error) in
            if error == nil {
                do{
                    let dataResponse = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                   
                    DispatchQueue.main.async {
                        self.movies = dataResponse["results"] as! Array<[String : Any]>
                        self.moviesTableView.reloadData()
                    }
                    
                }catch{
                    print(error)
                    
                }
            }
            }.resume()  */
    }
    
    // go to the favorite movies view
    @IBAction private func favoriteMoviesB(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



