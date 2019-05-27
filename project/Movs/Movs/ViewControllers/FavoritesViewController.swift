//
//  FavoritesViewController.swift
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

public class FavoritesViewController: UIViewController {
    
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    
    @IBOutlet var tvFavorites : UITableView!
    @IBOutlet var movieSearchBar : UISearchBar!
    
    //MARK: - • PRIVATE PROPERTIES
    private var needRefresh : Bool = true
    private var searchConnection : ConnectionManager = ConnectionManager.init()
    //
    private var currentYear : Int? = nil
    private var currentGenre : Dictionary<String, Any>? = nil
    private var currentQuery : String? = nil
    //
    private var favoritesList : Array<Dictionary<String, Any>> = Array.init()
    private var filteredFavoritesList : Array<Dictionary<String, Any>> = Array.init()
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
        
        let nib : UINib = UINib.init(nibName: "FavoriteTVC", bundle: nil)
        tvFavorites.register(nib, forCellReuseIdentifier: "FavoriteTVCIdentifier")
        
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterYear(notification:)), name: NSNotification.Name(rawValue: "FilterYearDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterGenre(notification:)), name: NSNotification.Name(rawValue: "FilterGenreDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionFavoriteChange(notification:)), name: NSNotification.Name(rawValue: "FavoriteDidChange"), object: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (tvFavorites.tag == 0){
            self.setupLayout(screenName: "Favoritos")
        }
        
        if (needRefresh){
            self.updateFavorites()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
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
        
        //Table
        tvFavorites.backgroundColor = UIColor.white
        tvFavorites.tableFooterView = UIView.init()
        tvFavorites.tag = 1
        tvFavorites.separatorColor = UIColor.white
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    
    @objc private func actionFilter(sender : Any?) {
        self.performSegue(withIdentifier: "SegueToMainFilter", sender: nil)
    }
    
    @objc private func actionFavoriteMovie(gesture : UITapGestureRecognizer) {
        let movie = favoritesList[gesture.view!.tag]
        let movieID : Int = movie["id"] as! Int
        //
        FavoriteMovieManager.saveFavorite(movieID: movieID)
        tvFavorites.reloadData()
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
        
        filteredFavoritesList = favoritesList.map{ $0 }
        
        if (self.currentYear != nil){
            filteredFavoritesList = filteredFavoritesList.filter{ ($0["release_date"] as! String).hasPrefix(String.init(self.currentYear!)) }
        }
        
        if (self.currentGenre != nil){
            let genreID:Int = self.currentGenre!["id"] as! Int
            filteredFavoritesList = filteredFavoritesList.filter{ ($0["genre_ids"] as! Array).contains(genreID) }
        }
        
        if (self.currentQuery != nil && self.currentQuery != ""){
            filteredFavoritesList = filteredFavoritesList.filter{ ($0["title"] as! String).contains(self.currentQuery!) }
        }
        
        //order by year
        if (filteredFavoritesList.count > 0){
            filteredFavoritesList = (filteredFavoritesList as NSArray).sortedArray(using: [NSSortDescriptor(key: "title", ascending: true)]) as! [[String:AnyObject]]
        }
        
        tvFavorites.reloadData()
        
    }
    
    private func updateFavorites() {
        
        favoritesList = Array.init()
        
        let favorites : Array<Int> = FavoriteMovieManager.allFavorites()
        
        if (favorites.count > 0){
            
            let totalF : Int = favorites.count
            
            let dGroup : DispatchGroup = DispatchGroup()
            
            for i in 0..<(totalF) {
                
                dGroup.enter()
                
                let movieID : Int = favorites[i]
                let connectionManager = ConnectionManager.init()
                connectionManager.getMovieDetail(movieID: movieID) { (movieDic, responseCode, error) in
                    if (error == nil){
                        if let completeResult = movieDic {
                            self.favoritesList.append(completeResult)
                        }
                    }
                    dGroup.leave()
                }
            }
            
            dGroup.notify(queue: DispatchQueue.main) {
                self.applyFilters()
            }
            
        }else{
            
            self.applyFilters()
            
        }
        
    }
}

//MARK: -

extension FavoritesViewController : UISearchBarDelegate {
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        //
        if (searchBar.text == ""){
            self.currentQuery = nil
        }else{
            self.currentQuery = searchBar.text
        }
        //
        self.applyFilters()
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //timer:
        if (refreshDataTimer != nil){
            refreshDataTimer?.invalidate()
        }
        //
        if (searchText.count >= 1){
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

extension FavoritesViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remover"
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (self.currentYear != nil || self.currentGenre != nil){
            return 40.0
        }else{
            return 0.0
        }
    }
}

extension FavoritesViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFavoritesList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FavoriteTVC? = tableView .dequeueReusableCell(withIdentifier: "FavoriteTVCIdentifier") as? FavoriteTVC
        if (cell == nil){
            cell = FavoriteTVC.init(style: .default, reuseIdentifier: "FavoriteTVCIdentifier")
        }
        
        let movie = filteredFavoritesList[indexPath.row]
        //let movieID : Int = movie["id"] as! Int
        
        cell!.setupLayout()
        
        //title
        cell!.lblMovieTitle.text = (movie["title"] as! String)
        
        //year
        let year : String? = (movie["release_date"] as? String)
        if (year == nil || year == ""){
            cell!.lblMovieYear.text = "-"
        }else{
            cell!.lblMovieYear.text = year!.components(separatedBy: "-").first
        }
        
        //descrição
        cell!.lblMovieDescription.text = (movie["overview"] as? String) == "" ? "Sem descrição..." : (movie["overview"] as? String)
        
        //poster
        if let posterURL : String = (movie["poster_path"] as? String) {
            var urlSTR : String = "https://image.tmdb.org/t/p/w500<POSTERPATH>"
            urlSTR = urlSTR.replacingOccurrences(of: "<POSTERPATH>", with: posterURL)
            cell!.updatePoster(fromURL: urlSTR)
        }
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (self.currentYear != nil || self.currentGenre != nil){
            
            let container : UIView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 40.0))
            
            let button : UIButton = UIButton.init(frame: container.frame)
            button.backgroundColor = App.Style.color2
            button.setTitleColor(App.Style.color1, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            button.setTitle("Remover Filtros", for: .normal)
            button.isExclusiveTouch = true
            button.addTarget(self, action: #selector(actionRemoveFilters(sender:)), for: .touchUpInside)
            
            container.addSubview(button)
            
            return container
            
        }else{
            return nil
        }
        
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let movie = filteredFavoritesList[indexPath.row]
            let movieID : Int = movie["id"] as! Int
            if let index = favoritesList.index(where: { ($0["id"] as! Int) == movieID}) {
                favoritesList.remove(at: index)
                FavoriteMovieManager.removeFavorite(movieID: movieID)
                //
                self.applyFilters()
                //
                
            }
        }
    }
}

//MARK: - PROTOCOLS
