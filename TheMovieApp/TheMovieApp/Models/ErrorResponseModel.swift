//
//  ErrorResponseModel.swift
//  TheMovieApp
//


import Foundation

class ErrorResponseModel: Codable {
    
    var statusCode:Int
    var errorMessage:String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case errorMessage = "status_message"
    }
    
    func getError() -> Error {
        return NSError(domain: Bundle.main.bundleIdentifier ?? "", code:statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMessage])
    }
}
