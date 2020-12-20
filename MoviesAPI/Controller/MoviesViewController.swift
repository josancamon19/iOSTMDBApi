//
//  ViewController.swift
//  MoviesAPI
//
//  Created by Joan Cabezas on 13/12/20.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    private var movies = [Movie]()
    
    private let movieListTypes = ["Popular", "Oscars 2012", "DC Comics", "Oscars 2011", "Avengers", "Others"]
    private var toolBar = UIToolbar()
    private var picker  = UIPickerView()
    
    private var selectedMoviesType = 1
    private var selectedMoviesTypePicker = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
    }
    
    func loadMovies(){
        MoviesAPI.getMoviesList(moviesType: selectedMoviesType, onCompleted: { (movies) in
            self.movies = movies
            self.moviesCollection.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieViewCell {
            cell.setMovieData(movie: movies[indexPath.row])
            return cell
        }
        return MovieViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewMovieDetail", sender: movies[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.setMovieData(movie: sender as! Movie)
        }
    }
    
    
}

extension MoviesViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieListTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return movieListTypes[row]
    }
    
    @IBAction func OnMoviesListTypeTapped(_ sender: UIButton) {
    
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
//        picker.selectedRow(inComponent: selectedMoviesType - 1)
        // TODO set the actually selected
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected row \(movieListTypes[row])")
        selectedMoviesTypePicker = row + 1
    }
    
    @objc func onDoneButtonTapped() {
        
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        
        if (selectedMoviesType != selectedMoviesTypePicker){
            selectedMoviesType = selectedMoviesTypePicker
            loadMovies()
        }
    }
}
