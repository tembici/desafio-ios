//
//  MainFilterViewController.swift
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

public class MainFilterViewController: UIViewController {
    
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    
    public var yearFilter : Int = 0
    public var genreFilter : Dictionary<String, Any> = Dictionary.init()
    //
    @IBOutlet var tvFilter : UITableView!
    @IBOutlet var btnApply : UIButton!
    
    //MARK: - • PRIVATE PROPERTIES
    
    
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
        
        let nib : UINib = UINib.init(nibName: "FilterItemTVC", bundle: nil)
        tvFilter.register(nib, forCellReuseIdentifier: "FilterItemTVCIdentifier")
        
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterYear(notification:)), name: NSNotification.Name(rawValue: "FilterYearValueDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionFilterGenre(notification:)), name: NSNotification.Name(rawValue: "FilterGenreValueDidChange"), object: nil)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (tvFilter.tag == 0){
            self.setupLayout(screenName: "Filtros")
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tvFilter.isUserInteractionEnabled = true
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc : ValueFilterViewController = segue.destination as! ValueFilterViewController
        
        if (segue.identifier == "SegueToYearFilter") {
            vc.filterType = .date
            var dicParam:Dictionary<String, Any> = Dictionary.init()
            dicParam["value"] = self.yearFilter
            vc.currentFilter = dicParam
            //
            return
        }
        
        if (segue.identifier == "SegueToGenreFilter") {
            vc.filterType = .genre
            var dicParam:Dictionary<String, Any> = self.genreFilter.keys.count != 0 ? self.genreFilter : Dictionary.init()
            vc.currentFilter = dicParam
            //
            return
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
        
        //Table
        tvFilter.backgroundColor = UIColor.white
        tvFilter.tableFooterView = UIView.init()
        
        //Apply
        btnApply.backgroundColor = App.Style.color1
        btnApply.tintColor = App.Style.color2
        btnApply.titleLabel?.text = "Aplicar"
        btnApply.isExclusiveTouch = true
        btnApply.layer.cornerRadius = 4.0
        
        tvFilter.tag = 1
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    
    @IBAction func actionApply(sender : Any?) {
        
        if (yearFilter != 0){
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterYearDidChange"), object: self.yearFilter)
            }
        }
        
        if (genreFilter.keys.count != 0){
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterGenreDidChange"), object: (self.genreFilter["id"] as! Int))
            }
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    
    @objc private func actionFilterYear(notification:Notification) {
        self.yearFilter = notification.object as! Int
        tvFilter.reloadData()
    }
    
    @objc private func actionFilterGenre(notification:Notification) {
        self.genreFilter = notification.object as! Dictionary<String, Any?>
        tvFilter.reloadData()
    }
    
}

extension MainFilterViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.isUserInteractionEnabled = false
        
        if (indexPath.row == 0){
            //Year
            self.performSegue(withIdentifier: "SegueToYearFilter", sender: nil)
        }else{
            //Genre
            self.performSegue(withIdentifier: "SegueToGenreFilter", sender: nil)
        }
    }
}

extension MainFilterViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FilterItemTVC? = tableView .dequeueReusableCell(withIdentifier: "FilterItemTVCIdentifier") as? FilterItemTVC
        if (cell == nil){
            cell = FilterItemTVC.init(style: .default, reuseIdentifier: "FilterItemTVCIdentifier")
        }
        
        cell?.setupLayout()
        
        if (indexPath.row == 0){
            //Year
            cell?.lblFilterName.text = "Ano"
            //
            if (self.yearFilter != 0){
                cell?.lblFilterValue.text = String(self.yearFilter)
            }else{
                cell?.lblFilterValue.text = "Todos"
            }
        }else{
            //Genre
            cell?.lblFilterName.text = "Gênero"
            //
            if (self.genreFilter.keys.count != 0){
                cell?.lblFilterValue.text = self.genreFilter["name"] as? String
            }else{
                cell?.lblFilterValue.text = "Todos"
            }
        }
        
        return cell!
    }
    
}

//MARK: - PROTOCOLS
