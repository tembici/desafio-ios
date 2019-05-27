//
//  ConnectionManager.swift
//  Project-Swift
//
//  Created by Erico GT on 3/30/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

//MARK: - • INTERFACE HEADERS
//import Alamofire
//import SwiftyJSON

//MARK: - • FRAMEWORK HEADERS
import UIKit

//MARK: - • OTHERS IMPORTS

//@objc protocol ConnectionManagerDelegate:NSObjectProtocol
//{
//    @objc optional func didConnectWithSuccess(response:Dictionary<String, Any>)
//    @objc optional func didConnectWithFailure(error:NSError)
//    @objc optional func didConnectWithSuccess(responseData:Data)
//    @objc optional func didConnectWithSuccess(progress:Float)
//}

class ConnectionManager
{
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    
    var isConnectionReachable:Bool{
        return (Reachability()?.isReachable)!
    }
    
    var isConnectionReachableViaWiFi:Bool{
        return (Reachability()?.isReachableViaWiFi)!
    }
    
    var currentTask : URLSessionDataTask?
    
    //MARK: - • PRIVATE PROPERTIES
    
    private let APIKEY : String = "60be203147c04647aeeea0ee189843fb"
    
    //MARK: - • INITIALISERS
    init() {
    }
    
    //MARK: - • CUSTOM ACCESSORS (SETS & GETS)
    
    
    //MARK: - • DEALLOC
    
    deinit {
        // NSNotificationCenter no longer needs to be cleaned up!
    }
    
    //MARK: - • SUPER CLASS OVERRIDES
    
    
    //MARK: - • INTERFACE/PROTOCOL METHODS
    
    
    //MARK: - • PUBLIC METHODS
    
    func getNowPlayingMovies(page:Int, handler:@escaping (_ responseDic:Dictionary<String, Any>?, _ statusCode:Int, _ error:Error?) -> ()){
        
        if (currentTask != nil){
            currentTask?.cancel()
        }
        
        //let postData = NSData(data: "{}".data(using: String.Encoding.utf8, allowLossyConversion: false) ?? <#default value#>
        
        var urlSTR : String = "https://api.themoviedb.org/3/movie/now_playing?api_key=<APIKEY>&language=pt-BR&page=<PAGE>"
        //
        urlSTR = urlSTR.replacingOccurrences(of: "<APIKEY>", with: APIKEY)
        //
        urlSTR = urlSTR.replacingOccurrences(of: "<PAGE>", with: String.init(page))
        
        let url : URL? = URL.init(string: urlSTR)
        
        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let session : URLSession = URLSession.shared
        currentTask = session.dataTask(with: request as URLRequest) { (dData, dResponse, dError) in
            
            var code : Int = 0
            if let httpResponse = dResponse as? HTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if (dError != nil){
                handler(nil, code, dError)
            }else{
                
                if let d = dData {
                    if let json = (try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
                        handler(json, code, nil)
                    }else{
                        handler(nil, code, nil)
                    }
                }else{
                    handler(nil, code, nil)
                }
            }
            
        }
        
        currentTask!.resume()
    }
    
    func getMovieDetail(movieID:Int, handler:@escaping (_ responseDic:Dictionary<String, Any>?, _ statusCode:Int, _ error:Error?) -> ()){
        
        if (currentTask != nil){
            currentTask?.cancel()
        }
        
        var urlSTR : String = "https://api.themoviedb.org/3/movie/<MOVIEID>?api_key=<APIKEY>&language=pt-BR"
        urlSTR = urlSTR.replacingOccurrences(of: "<MOVIEID>", with: String(movieID))
        urlSTR = urlSTR.replacingOccurrences(of: "<APIKEY>", with: APIKEY)

        let url : URL? = URL.init(string: urlSTR)
        
        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let session : URLSession = URLSession.shared
        currentTask = session.dataTask(with: request as URLRequest) { (dData, dResponse, dError) in
            
            var code : Int = 0
            if let httpResponse = dResponse as? HTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if (dError != nil){
                handler(nil, code, dError)
            }else{
                
                if let d = dData {
                    if let json = (try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
                        
                        if let _ = json["id"] as? Int {
                            handler(json, code, nil)
                        }else{
                            handler(nil, code, nil)
                        }
                        
                    }
                }else{
                    handler(nil, code, nil)
                }
            }
            
        }
        
        currentTask!.resume()
    }
    
    func searchMovies(page:Int, filterText:String?, filterYear:Int?, handler:@escaping (_ responseDic:Dictionary<String, Any>?, _ statusCode:Int, _ error:Error?) -> ()){
        
        if (currentTask != nil){
            currentTask?.cancel()
        }
        
        //let postData = NSData(data: "{}".data(using: String.Encoding.utf8, allowLossyConversion: false) ?? <#default value#>
        
        var urlSTR : String = "https://api.themoviedb.org/3/search/movie?api_key=<APIKEY>&language=pt-BR&page=<PAGE>&include_adult=false&query=<QUERY>&year=<YEAR>"
        //
        urlSTR = urlSTR.replacingOccurrences(of: "<APIKEY>", with: APIKEY)
        //
        urlSTR = urlSTR.replacingOccurrences(of: "<PAGE>", with: String.init(page))
        //
        if (filterText != nil) {
            urlSTR = urlSTR.replacingOccurrences(of: "<QUERY>", with: filterText!)
        }else{
            urlSTR = urlSTR.replacingOccurrences(of: "<QUERY>", with: "''")
        }
        //
        if (filterYear != nil) {
            urlSTR = urlSTR.replacingOccurrences(of: "<YEAR>", with: String.init(filterYear!))
        }else{
            urlSTR = urlSTR.replacingOccurrences(of: "<YEAR>", with: "")
        }
        
        let url : URL? = URL.init(string: urlSTR)
        
        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let session : URLSession = URLSession.shared
        currentTask = session.dataTask(with: request as URLRequest) { (dData, dResponse, dError) in
            
            var code : Int = 0
            if let httpResponse = dResponse as? HTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if (dError != nil){
                handler(nil, code, dError)
            }else{
                
                if let d = dData {
                    if let json = (try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
                        handler(json, code, nil)
                    }else{
                        handler(nil, code, nil)
                    }
                }else{
                    handler(nil, code, nil)
                }
            }
            
        }
        
        currentTask!.resume()
    }
    
    func getGenres(handler:@escaping (_ responseDic:Array<Dictionary<String, Any>>?, _ statusCode:Int, _ error:Error?) -> ()){
        
        if (currentTask != nil){
            currentTask?.cancel()
        }
        
        var urlSTR : String = "https://api.themoviedb.org/3/genre/movie/list?api_key=<APIKEY>&language=pt-BR"
        urlSTR = urlSTR.replacingOccurrences(of: "<APIKEY>", with: APIKEY)
        //
        let url : URL? = URL.init(string: urlSTR)
        
        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let session : URLSession = URLSession.shared
        currentTask = session.dataTask(with: request as URLRequest) { (dData, dResponse, dError) in
            
            var code : Int = 0
            if let httpResponse = dResponse as? HTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if (dError != nil){
                handler(nil, code, dError)
            }else{
                
                if let d = dData {
                    if let json = (try? JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
                        
                        if let genresList:Array<Dictionary<String, Any>> = json["genres"] as? Array<Dictionary<String, Any>> {
                            handler(genresList, code, nil)
                        }else{
                           handler(nil, code, nil)
                        }
                        
                    }else{
                        handler(nil, code, nil)
                    }
                }else{
                    handler(nil, code, nil)
                }
            }
            
        }
        
        currentTask!.resume()
    }
    
    func getPoster(posterPath : String, handler:@escaping (_ image:UIImage?, _ statusCode:Int, _ error:Error?) -> ()){
        
        if (currentTask != nil){
            currentTask?.cancel()
        }
        
        //var urlSTR : String = "https://image.tmdb.org/t/p/original<POSTERPATH>"
        //urlSTR = urlSTR.replacingOccurrences(of: "<POSTERPATH>", with: posterPath)
        let url : URL? = URL.init(string: posterPath)
        
        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let session : URLSession = URLSession.shared
        currentTask = session.dataTask(with: request as URLRequest) { (dData, dResponse, dError) in
            
            var code : Int = 0
            if let httpResponse = dResponse as? HTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            if (dError != nil){
                handler(nil, code, dError)
            }else{
                
                if let d = dData {
                    let img:UIImage? = UIImage.init(data: d)
                    handler(img, code, nil)
                }else{
                    handler(nil, code, nil)
                }
            }
            
        }
        
        currentTask!.resume()
    }
    
    //MARK: - • ACTION METHODS
    
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    private func getDeviceInfo() ->  Dictionary<String, String>{
        
        var deviceDic:Dictionary<String, String> =  Dictionary.init()
        //
        deviceDic["name"] = ToolBox.Device.name()
        deviceDic["model"] = String.init(format: "Apple - %@", arguments: [ToolBox.Device.model()])
        deviceDic["system_version"] = ToolBox.Device.systemVersion()
        deviceDic["system_language"] = ToolBox.Device.systemLanguage()
        deviceDic["storage_capacity"] = ToolBox.Device.storageCapacity()
        deviceDic["free_memory_space"] = ToolBox.Device.freeMemorySpace()
        deviceDic["identifier_for_vendor"] = ToolBox.Device.identifierForVendor()
        deviceDic["app_version"] = ToolBox.Application.versionBundle()
        //
        return deviceDic
    }
    
//    private func createDefaultHeader() -> HTTPHeaders{
//        
//        let token:String? = UserDefaults.standard.value(forKey: "PLISTKEY_ACCESS_TOKEN") as! String?
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Accept": "application/json",
//            "idiom": NSLocalizedString("LANGUAGE_APP", comment: ""),
//            "device_info": ToolBox.Converter.stringJsonFromDictionary(dictionary: getDeviceInfo() as NSDictionary, prettyPrinted: false),
//            "token": ToolBox.isNil(token as AnyObject?) ? "" :  token!
//        ]
//        return header
//    }
}




