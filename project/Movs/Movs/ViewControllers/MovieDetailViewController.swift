//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by lordesire on 25/05/2019.
//  Copyright © 2019 EricoGT. All rights reserved.
//

//MARK: - • INTERFACE HEADERS

//MARK: - • FRAMEWORK HEADERS
import UIKit

//MARK: - • OTHERS IMPORTS

//MARK: - • EXTENSIONS

//MARK: - • CLASSES

public class MovieDetailViewController: UIViewController {
    
    //MARK: - • LOCAL DEFINES
    
    //MARK: - • PUBLIC PROPERTIES
    
    var movieID : Int = 0
    //
    @IBOutlet var imvPoster : UIImageView!
    @IBOutlet var tvFilter : UITableView!
    @IBOutlet var actIndicator : UIActivityIndicatorView!
    
    //MARK: - • PRIVATE PROPERTIES
    
    private var isFavorite:Bool = false
    private var movieDetail:Dictionary<String, Any> = Dictionary.init()
    
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
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupLayout(screenName: "Detalhe")
        
        self.loadMovieDetail()
        
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
        
        imvPoster.backgroundColor = App.Style.color1
        imvPoster.image = nil
        
        actIndicator.color = App.Style.color2
        actIndicator.stopAnimating()
        
        //Table
        tvFilter.backgroundColor = UIColor.white
        tvFilter.tableFooterView = UIView.init()
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    
    private func loadMovieDetail() {
        
        let connectionManager = ConnectionManager.init()
        
        connectionManager.getMovieDetail(movieID: movieID) { (movieDic, responseCode, error) in

            if (error != nil){
                
                let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                //
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if let completeResult = movieDic {
                    self.movieDetail = completeResult
                    //
                    if let posterURL : String = (completeResult["backdrop_path"] as? String) {
                        var urlSTR : String = "https://image.tmdb.org/t/p/original<POSTERPATH>"
                        urlSTR = urlSTR.replacingOccurrences(of: "<POSTERPATH>", with: posterURL)
                        self.updatePoster(fromURL: urlSTR)
                    }
                    //
                    DispatchQueue.main.async {
                        self.tvFilter.reloadData()
                    }
                }else{
                    
                    let alert = UIAlertController.init(title: "Erro", message: "Os detalhes do filme não puderam ser carregados no momento. Por favor, tente mais tarde!", preferredStyle: .alert)
                    let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    //
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            
        }
        
    }
    
    private func updatePoster(fromURL : String){
        
        let connectionManager = ConnectionManager.init()
        
        if let img : UIImage = App.Delegate.imageCache.object(forKey: fromURL as AnyObject) as? UIImage {
            self.imvPoster.image = img
        }else{
            self.actIndicator.startAnimating()
            //
            connectionManager.getPoster(posterPath: fromURL) { (image, code, error) in
                DispatchQueue.main.async {
                    if let img = image {
                        App.Delegate.imageCache.setObject(img, forKey: fromURL as AnyObject)
                        self.imvPoster.image = img
                    }
                    self.actIndicator.stopAnimating()
                }
            }
        }
        
    }
    
}

//MARK: -

extension MovieDetailViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row != 3){
            return 44.0
        }else{
            return UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if (indexPath.row == 0){
            if (!isFavorite){
                FavoriteMovieManager.saveFavorite(movieID: movieID)
                tvFilter.reloadData()
            }
        }
        
    }
}

extension MovieDetailViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (movieDetail.keys.count == 0){
            return 0
        }else{
            return 4
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row != 3){
            
            var cell : MovieItemTVC? = tableView .dequeueReusableCell(withIdentifier: "MovieItemTVCIdentifier") as? MovieItemTVC
            if (cell == nil){
                cell = MovieItemTVC.init(style: .default, reuseIdentifier: "MovieItemTVCIdentifier")
            }
            cell?.setupLayout()
            
            if (indexPath.row == 0){
                cell?.lblItem.text = movieDetail["title"] as? String
                cell?.imvFavorite.isHidden = false
                if (FavoriteMovieManager.checkFavorite(movieID: movieID)){
                    cell?.imvFavorite.image = UIImage.init(named: "IconFavoriteFull")
                    isFavorite = true
                }
            }
            //
            else if (indexPath.row == 1){
                cell?.lblItem.text = (movieDetail["release_date"] as? String) == "" ? "Sem data lançamento..." : (movieDetail["release_date"] as? String)
            }
            //
            else if (indexPath.row == 2){
                let g = (movieDetail["genres"] as! Array<Dictionary<String, Any>>).map { ($0["name"] as! String) }.joined(separator: ", ")
                cell?.lblItem.text = g == "" ? "Gênero indefinido..." : g
            }
            
            return cell!
            
        }else{
            
            var cell : MovieLargeItemTVC? = tableView .dequeueReusableCell(withIdentifier: "MovieLargeItemTVCIdentifier") as? MovieLargeItemTVC
            if (cell == nil){
                cell = MovieLargeItemTVC.init(style: .default, reuseIdentifier: "MovieLargeItemTVCIdentifier")
            }
            cell?.setupLayout()
            
            cell?.lblItem.text = (movieDetail["overview"] as? String) == "" ? "Sem descrição..." : (movieDetail["overview"] as? String)
            
            return cell!
        }
        
    }
    
}

//MARK: - PROTOCOLS
