//
//  AllMoviesGet.swift
//  ShowMovies
//
//  Created by Islam Gharib on 1/15/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import Foundation
// modeling movies api
struct AllMoviesGet {
    let vote_count:Int
    let id:Int
    let video:Bool
    let vote_average:Double
    let title:String
    let popularity:Double
    let poster_path:String
    let original_language:String
    let original_title:String
    let genre_ids:[Int]
    let backdrop_path:String
    let adult:Bool
    let overview:String
    let release_date:String
}

