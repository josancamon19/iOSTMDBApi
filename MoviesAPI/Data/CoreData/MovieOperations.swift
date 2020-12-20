//
//  MovieOperations.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 19/12/20.
//

import UIKit
import CoreData

let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

func saveMoviesToCoreData(data: [Movie] , category:Int){
    clearForCategory(category: category)
    for movie in data {
        saveToCoreData(data: movie, category: category)
    }
    saveLastTimeMoviesSaved(category: category)
}

func saveToCoreData(data : Movie, category: Int) {
    let movie = MovieDb(context: managedContext)
    data.toMovieDb(movieDb: movie, category: category)
    do {
        try managedContext.save()
    } catch {
        debugPrint("Could not save: \(error.localizedDescription)")
    }
}

func getMoviesFromCoreData(category: Int) -> [Movie]{
    let fetchRequest = NSFetchRequest<MovieDb>(entityName: "MovieDb")
    fetchRequest.predicate = NSPredicate(format: "category==\(category)")
    do{
        let moviesData = try managedContext.fetch(fetchRequest) // throws
        return moviesData.map { (movieDb) -> Movie in
            return Movie.fromMovieDb(movieDb: movieDb)!
        }
    }catch{
        debugPrint("Unable to read \(error.localizedDescription)")
    }
    return [Movie]()
}

func clearForCategory(category: Int){
    let fetchRequest = NSFetchRequest<MovieDb>(entityName: "MovieDb")
    fetchRequest.predicate = NSPredicate(format: "category==\(category)")
    do{
        let moviesData = try managedContext.fetch(fetchRequest) // throws
        for movie in moviesData {
            managedContext.delete(movie)
        }
    } catch {
        debugPrint("Unable to read \(error.localizedDescription)")
    }
}


func clearCoreData(){
    let fetchRequest = NSFetchRequest<MovieDb>(entityName: "MovieDb")
    do{
        let moviesData = try managedContext.fetch(fetchRequest) // throws
        for movie in moviesData {
            managedContext.delete(movie)
        }
    } catch {
        debugPrint("Unable to read \(error.localizedDescription)")
    }
}
