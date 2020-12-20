//
//  MoviesAPI.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 13/12/20.
//

import Foundation
import Networking
import CoreData

let api = Networking(baseURL: "http://api.themoviedb.org/4/")
let apiKey = "5b457fd223b36746a494b0f20be527db"

func getMoviesList(moviesType:Int = 1, onCompleted: @escaping (_ movies :[Movie]) -> Void) -> Void{
    if (!dbMoviesRequireReloading(category: moviesType)) {
        let moviesList = getMoviesFromCoreData(category: moviesType)
        print("Category \(moviesType) loaded from Database \(moviesList.count)")
        onCompleted(moviesList)
        return
    }
    api.get("list/\(moviesType)?api_key=\(apiKey)"){ result in
        switch result {
        case .success(let response):
            var moviesList = [Movie]()
            if let movies = response.dictionaryBody["results"] as? [Dictionary<String, Any>] {
                for movieDict in movies {
                    if let movie = Movie.fromJson(dict: movieDict) {
                        moviesList.append(movie)
                    }
                }
            }
            print("Category \(moviesType) loaded from API")
            saveMoviesToCoreData(data: moviesList, category: moviesType)
            onCompleted(moviesList)
        case .failure(let response):
            print(response)
        }
    }
}

func getPosterURL(imagePath: String) -> String{
    return "https://image.tmdb.org/t/p/w500/\(imagePath)"
}

