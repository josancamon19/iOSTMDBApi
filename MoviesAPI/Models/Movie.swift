//
//  Movie.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 13/12/20.
//

import Foundation

class Movie {
    var id : Int
    var language : String
    var title : String
    var overview : String
    var popularity  :Float
    var imagePath : String
    var votes : Float
    var releaseDate : String
    
    init(id: Int, language :String, title: String, overview:String, popularity: Float, imagePath: String, votes: Float,  releaseDate : String) {
        self.id = id
        self.language = language
        self.title = title
        self.overview = overview
        self.popularity = popularity
        self.imagePath = imagePath
        self.votes = votes
        self.releaseDate = releaseDate
    }
    
    static func fromJson(dict : Dictionary<String, Any>) -> Movie? {
        if let id = dict["id"] as? NSNumber, let title = dict["title"] as? String, let language = dict["original_language"] as? String, let overview = dict["overview"] as? String, let popularity = dict["popularity"] as? NSNumber, let imagePath = dict["poster_path"] as? String, let votes = dict["vote_average"] as? NSNumber, let releaseDate = dict["release_date"] as? String  {
            let movie: Movie = Movie(id: id.intValue, language: language, title: title, overview: overview, popularity: popularity.floatValue, imagePath: imagePath, votes: votes.floatValue, releaseDate: releaseDate)
            return movie
        }
        return nil
    }
    
    func toMovieDb(movieDb : MovieDb, category: Int){
        movieDb.id = Int32(id)
        movieDb.title = title
        movieDb.language = language
        movieDb.category = Int16(category)
        movieDb.imagePath = imagePath
        movieDb.overview = overview
        movieDb.votes = votes
        movieDb.popularity = popularity
        movieDb.releaseDate = releaseDate
    }
    
    static func fromMovieDb(movieDb : MovieDb) -> Movie? {
        return Movie(id: Int(movieDb.id), language: movieDb.language ?? "Not found", title: movieDb.title ?? "Not found", overview: movieDb.overview ?? "Not found", popularity: movieDb.popularity, imagePath: movieDb.imagePath ?? "Not found", votes: movieDb.votes, releaseDate: movieDb.releaseDate ?? "Not found")
    }
}
