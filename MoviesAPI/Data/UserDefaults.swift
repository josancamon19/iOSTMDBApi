//
//  UserDefaults.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 19/12/20.
//

import Foundation

let defaults = UserDefaults.init()

func saveLastTimeMoviesSaved(category: Int){
    defaults.set(Date(), forKey: "time_movies_downloaded_\(category)")
}

func dbMoviesRequireReloading(category: Int)  -> Bool{
    if let lastSave = getLastTimeMoviesSaved(category: category) {
        let secondsDiff = Date().timeIntervalSince(lastSave)
        return secondsDiff > 3600 * 24
    }
    return true
}

func getLastTimeMoviesSaved(category: Int) ->Date? {
    return defaults.object(forKey: "time_movies_downloaded_\(category)") as? Date
}
