//
//  favoriteMovies.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/5/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit
import CoreData
class favoriteMovies: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var favoriteMovie = [Movies]()
    @IBOutlet private weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        loadItems()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovie.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavoriteMoviesTVC = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteMoviesTVC
        cell.movieTitleLB.text = favoriteMovie[indexPath.row].title
        cell.movieOverviewTV.text = favoriteMovie[indexPath.row].overview
        
        let posterPath = favoriteMovie[indexPath.row].posterImage as! String
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + posterPath)
        cell.moviePosterImage.af_setImage(withURL:imageUrl!)
        
        // to listen to delete button
        cell.deleteB.tag = indexPath.row
        cell.deleteB.addTarget(self, action: #selector(deleteMovie(_:)), for: .touchUpInside)
        
        return cell
    }
    
    private func loadItems(){
        let fetchRequest:NSFetchRequest<Movies> = Movies.fetchRequest()
        
        do {
            favoriteMovie = try context.fetch(fetchRequest)
            
            favoriteTableView.reloadData()
        } catch{
            print("Can't load Items")
        }
    }
    @objc func deleteMovie(_ sender: UIButton) {
        context.delete(favoriteMovie[sender.tag])
        loadItems()
    }
    
}
