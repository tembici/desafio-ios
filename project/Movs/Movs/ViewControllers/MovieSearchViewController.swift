//
//  MovieSearchViewController.swift
//  Movs
//
//  Created by lordesire on 23/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

//MARK: - • INTERFACE HEADERS

//MARK: - • FRAMEWORK HEADERS
import UIKit

//MARK: - • OTHERS IMPORTS

//MARK: - • EXTENSIONS

//MARK: - • CLASSES

public class MovieSearchViewController: UIViewController {
    
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    @IBOutlet var movieCollection : UICollectionView!
    @IBOutlet var movieSearchBar : UISearchBar!
    
    //MARK: - • PRIVATE PROPERTIES
    private var needRefresh : Bool = true
    private var searchConnection : ConnectionManager = ConnectionManager.init()
    //
    private var currentPage : Int = 1
    private var totalPages : Int = 1
    private var currentYear : Int? = nil
    private var currentGenre : Dictionary<String, Any>? = nil
    private var currentQuery : String? = nil
    //
    private var moviesList : Array<Dictionary<String, Any>> = Array.init()
    private var filteredMoviesList : Array<Dictionary<String, Any>> = Array.init()
    //
    private var refreshDataTimer : Timer? = nil
    
    //MARK: - • INITIALISERS
    
    
    //MARK: - • CUSTOM ACCESSORS (SETS & GETS)
    
    
    //MARK: - • DEALLOC
    
    deinit {
        // NSNotificationCenter no longer needs to be cleaned up!
    }
    
    //MARK: - • SUPER CLASS OVERRIDES
    
    
    //MARK: - • CONTROLLER LIFECYCLE/ TABLEVIEW/ DATA-SOURCE
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        let nib : UINib = UINib.init(nibName: "MovieCVC", bundle: nil)
        movieCollection.register(nib, forCellWithReuseIdentifier: "MovieCVCIdentifier")
        
        let headerNib : UINib = UINib.init(nibName: "FilterButtonCVH", bundle: nil)
        movieCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterButtonCVHIdentifier")
        
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterYear(notification:)), name: NSNotification.Name(rawValue: "FilterYearDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterGenre(notification:)), name: NSNotification.Name(rawValue: "FilterGenreDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionFavoriteChange(notification:)), name: NSNotification.Name(rawValue: "FavoriteDidChange"), object: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (movieCollection.tag == 0){
            self.setupLayout(screenName: "Filmes")
        }
        
        if (needRefresh){
            self.searchMovies()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "SegueToMovieDetail") {
            let vc : MovieDetailViewController = segue.destination as! MovieDetailViewController
            vc.movieID = sender as! Int
        }
        
        if (segue.identifier == "SegueToMainFilter") {
            let vc : MainFilterViewController = segue.destination as! MainFilterViewController
            vc.yearFilter = self.currentYear ?? 0
            vc.genreFilter = self.currentGenre ?? Dictionary.init()
        }
    }
    
    //MARK: - • INTERFACE/PROTOCOL METHODS
    
    //MARK: -
    
    public func setupLayout(screenName:String){
        
        //Layout
        self.view.layoutIfNeeded()
        
        //Colors
        self.view.backgroundColor = UIColor.white
        //self.scrollViewBackground.backgroundColor = UIColor.clear
        
        //Navigation Controller
        self.navigationItem.title = screenName
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = App.Style.color1
        self.navigationController?.navigationBar.barTintColor = App.Style.color1
        self.navigationController?.navigationBar.tintColor = App.Style.color2
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: App.Style.color2, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TODO: left bar button
        let rightButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "IconFilter"), style: .plain, target: self, action: #selector(self.actionFilter(sender:)))
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        //Search
        //movieSearchBar.placeholder = "Procurar..."
        movieSearchBar.barTintColor = App.Style.color1
        movieSearchBar.tintColor = App.Style.color2
        movieSearchBar.showsCancelButton = false
        //movieSearchBar.inputAccessoryView = ???
        for v:UIView in movieSearchBar.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = App.Style.color3
            }
        }
        
        //Collection:
        movieCollection.backgroundColor = UIColor.clear
        movieCollection.tag = 1
        
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    
    @objc private func actionFilter(sender : Any?) {
        self.performSegue(withIdentifier: "SegueToMainFilter", sender: nil)
    }
    
    @objc private func actionFavoriteMovie(gesture : UITapGestureRecognizer) {
        let movie = filteredMoviesList[gesture.view!.tag]
        let movieID : Int = movie["id"] as! Int
        //
        FavoriteMovieManager.saveFavorite(movieID: movieID)
        movieCollection.reloadData()
    }
    
    @objc private func actionRemoveFilters(sender : Any?) {
        
        self.currentYear = nil
        self.currentGenre = nil
        //
        self.applyFilters()
        
    }
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    
    @objc private func actionFilterYear(notification:Notification) {
        self.currentYear = notification.object as? Int
        //
        self.applyFilters()
        needRefresh = false
    }
    
    @objc private func actionFilterGenre(notification:Notification) {
        self.currentGenre = (notification.object as! Dictionary<String, Any>)
        //
        self.applyFilters()
        needRefresh = false
    }
    
    @objc private func actionFavoriteChange(notification:Notification) {
        needRefresh = true
    }
    
    private func applyFilters() {
        
        filteredMoviesList = moviesList.map{ $0 }
        
        if (self.currentYear != nil){
            filteredMoviesList = filteredMoviesList.filter{ ($0["release_date"] as! String).hasPrefix(String.init(self.currentYear!)) }
        }
        
        if (self.currentGenre != nil){
            let genreID:Int = self.currentGenre!["id"] as! Int
            filteredMoviesList = filteredMoviesList.filter{ ($0["genre_ids"] as! Array).contains(genreID) }
        }
        
        movieCollection.reloadData()
        
        if (currentPage == 1){
            movieCollection.scrollRectToVisible(CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0), animated: true)
        }
        
    }
    
    private func searchMovies() {
        
        if (self.currentQuery == nil || self.currentQuery == "") {
            self.searchNowPlayingMovies()
        }else{
            self.searchFilteredMovies()
        }
        
        //movieCollection.reloadData()
        needRefresh = false
    }
    
    private func searchFilteredMovies() {
        searchConnection.searchMovies(page: currentPage, filterText: currentQuery, filterYear: currentYear) { (resultDic, responseCode, error) in
            
            if (error != nil){
                
                let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                //
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if let completeResult = resultDic {
                    
                    if (completeResult.keys.count == 0){
                        
                        let alert = UIAlertController.init(title: "Erro", message: "Nenhuma informação válida disponível!", preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        //
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        
                        self.currentPage = completeResult["page"] as! Int
                        self.totalPages = completeResult["total_pages"] as! Int
                        
                        if let movies:Array<Dictionary<String, Any>> = completeResult["results"] as? Array<Dictionary<String, Any>> {
                            if (movies.count == 0){
                                
                                let alert = UIAlertController.init(title: "Erro", message: "Nenhum item encontrado!", preferredStyle: .alert)
                                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                //
                                self.present(alert, animated: true, completion: nil)
                                
                            }else{
                                
                                if (self.currentPage == 1){
                                    self.moviesList = Array.init()
                                }
                                self.moviesList.append(contentsOf: movies)
                                //
                                DispatchQueue.main.async {
                                    self.applyFilters()
                                }
                            }
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    private func searchNowPlayingMovies() {
        searchConnection.getNowPlayingMovies(page: currentPage) { (resultDic, responseCode, error) in
            
            if (error != nil){
                
                let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                //
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if let completeResult = resultDic {
                    
                    if (completeResult.keys.count == 0){
                        
                        let alert = UIAlertController.init(title: "Erro", message: "Nenhuma informação válida disponível!", preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        //
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        
                        self.currentPage = completeResult["page"] as! Int
                        self.totalPages = completeResult["total_pages"] as! Int
                        
                        if let movies:Array<Dictionary<String, Any>> = completeResult["results"] as? Array<Dictionary<String, Any>> {
                            if (movies.count == 0){
                                
                                let alert = UIAlertController.init(title: "Erro", message: "Nenhum item encontrado!", preferredStyle: .alert)
                                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                //
                                self.present(alert, animated: true, completion: nil)
                                
                            }else{
                                
                                if (self.currentPage == 1){
                                    self.moviesList = Array.init()
                                }
                                self.moviesList.append(contentsOf: movies)
                                //
                                DispatchQueue.main.async {
                                    self.applyFilters()
                                }
                                
                            }
                        }
                    }
                    
                }
                
                
            }
            
        }
    }
}

//MARK: -

extension MovieSearchViewController : UISearchBarDelegate {
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    
        searchBar.showsCancelButton = false
        //
        if (searchBar.text == ""){
            self.currentQuery = nil
            self.currentPage = 1
            self.totalPages = 1
        }else{
            self.currentQuery = searchBar.text
        }
        //
        self.searchMovies()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //timer:
        if (refreshDataTimer != nil){
            refreshDataTimer?.invalidate()
        }
        //
        if (searchText.count >= 1){
            
            self.currentPage = 1
            self.totalPages = 1
            //
            self.currentQuery = searchText
            //
            refreshDataTimer = Timer.scheduledTimer(timeInterval: 0.5, target: searchBar, selector: #selector(resignFirstResponder), userInfo: nil, repeats: false)
            RunLoop.main.add(refreshDataTimer!, forMode: .common)
        }
        
    }
    
//    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//
//
//    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
   
}

extension MovieSearchViewController : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = filteredMoviesList[indexPath.row]
        let movieID : Int = movie["id"] as! Int
        self.performSegue(withIdentifier: "SegueToMovieDetail", sender: movieID)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if (indexPath.row == filteredMoviesList.count - 1 && currentPage < totalPages) {

            if (searchConnection.currentTask?.state != .running){
                currentPage += 1
                self.searchMovies()
            }

        }

    }
    
}

extension MovieSearchViewController : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMoviesList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MovieCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCIdentifier", for: indexPath) as! MovieCVC
        
        let movie = filteredMoviesList[indexPath.row]
        let movieID : Int = movie["id"] as! Int
        
        cell.setupLayout(favorite: FavoriteMovieManager.checkFavorite(movieID: movieID))
        
        cell.lblTitle.text = (movie["title"] as! String)
        
        if let posterURL : String = (movie["poster_path"] as? String) {
            var urlSTR : String = "https://image.tmdb.org/t/p/w500<POSTERPATH>"
            urlSTR = urlSTR.replacingOccurrences(of: "<POSTERPATH>", with: posterURL)
            cell.updatePoster(fromURL: urlSTR)
        }
        
        cell.layer.cornerRadius = 4.0
        
        //to favorite:
        cell.imvFavorite.isUserInteractionEnabled = true
        cell.imvFavorite.tag = indexPath.row
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(actionFavoriteMovie(gesture:)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        cell.imvFavorite.addGestureRecognizer(gesture)
        
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header : FilterButtonCVH = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterButtonCVHIdentifier", for: indexPath) as! FilterButtonCVH
            header.setupLayout(target: self, action: #selector(actionRemoveFilters(sender:)))
            //
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.sectionHeadersPinToVisibleBounds = true
            //
            return header

        }
        
        return UICollectionReusableView()
    }
    
}

extension MovieSearchViewController : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 30.0) / 2.0
        let height = width * 1.6
        //
        return CGSize.init(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if (self.currentYear != nil || self.currentGenre != nil){
            return CGSize.init(width: collectionView.frame.size.width, height: 40.0)
        }else{
            return CGSize.zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
}

//MARK: - PROTOCOLS
