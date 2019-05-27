//
//  YearFilterViewController.swift
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

public class ValueFilterViewController: UIViewController {
    
    //MARK: - • LOCAL DEFINES
    public enum FilterType : Int{
        case date = 1
        case genre = 2
    }
    
    //MARK: - • PUBLIC PROPERTIES
    
    public var filterType : FilterType = .date
    public var currentFilter : Dictionary<String, Any> = Dictionary.init()
    //
    @IBOutlet var tvFilter : UITableView!
    
    //MARK: - • PRIVATE PROPERTIES
    
    private var optionsList : Array<Dictionary<String, Any>> = Array.init()
    
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
        
        let nib : UINib = UINib.init(nibName: "FilterValueTVC", bundle: nil)
        tvFilter.register(nib, forCellReuseIdentifier: "FilterValueTVCIdentifier")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (filterType == .date){
            self.setupLayout(screenName: "Ano")
            self.loadYears()
        }else{
            self.setupLayout(screenName: "Gênero")
            self.loadGenres()
        }
        
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
        
        //Table
        tvFilter.backgroundColor = UIColor.white
        tvFilter.tableFooterView = UIView.init()
    }
    
    //MARK: - • PUBLIC METHODS
    
    
    //MARK: - • ACTION METHODS
    
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    
    private func loadYears() {
        
        let y:Int = ToolBox.Date.actualYear()
        
        for i in stride(from: y, through: (y - 30), by: -1) {
            var dic:Dictionary<String, Any?> = Dictionary.init()
            dic["value"] = i
            optionsList.append(dic)
        }
        
        tvFilter.reloadData()
    }
    
    private func loadGenres() {
        
        let connectionManager = ConnectionManager.init()
        connectionManager.getGenres { (resultList, responseCode, error) in
            
            if (error != nil){
                
                let alert = UIAlertController.init(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                //
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if let completeResult = resultList {
                    
                    if (completeResult.count == 0){
                        
                        let alert = UIAlertController.init(title: "Erro", message: "Nenhuma informação válida disponível!", preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        //
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        
                        self.optionsList = completeResult
                        
                        DispatchQueue.main.async {
                            self.tvFilter.reloadData()
                        }
                    }
                    
                }
                
                
            }
            
        }
    }
    
}

extension ValueFilterViewController : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentFilter = optionsList[indexPath.row]
        
        tableView.reloadData()
        tableView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            if (self.filterType == .date) {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterYearValueDidChange"), object: (self.currentFilter["value"] as! Int))
                }
            }else{
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterGenreValueDidChange"), object: self.currentFilter)
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
}

extension ValueFilterViewController : UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FilterValueTVC? = tableView .dequeueReusableCell(withIdentifier: "FilterValueTVCIdentifier") as? FilterValueTVC
        if (cell == nil){
            cell = FilterValueTVC.init(style: .default, reuseIdentifier: "FilterValueTVCIdentifier")
        }
        
        cell?.setupLayout()
        
        //value
        let item:Dictionary<String, Any?> = optionsList[indexPath.row]
        var currentFilterValue:String = ""
        
        if (self.filterType == .date) {
            currentFilterValue = String.init( item["value"] as! Int )
        }else{
            currentFilterValue = item["name"] as! String
        }
        cell?.lblFilterValue.text = currentFilterValue
        
        //check
        if (currentFilter.keys.count != 0){
            var selectedFilterValue:String = ""
            if (self.filterType == .date) {
                selectedFilterValue = String.init( currentFilter["value"] as! Int )
            }else{
                selectedFilterValue = currentFilter["name"] as! String
            }
            //
            if (currentFilterValue == selectedFilterValue){
                cell?.imvCheck.isHidden = false
            }
        }
        
        return cell!
    }
    
}

//MARK: - PROTOCOLS
