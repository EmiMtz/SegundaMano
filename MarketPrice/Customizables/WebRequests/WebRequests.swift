//
//  WebRequests.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 09/03/21.
//

import UIKit
import Foundation
import Alamofire

class WebRequests: NSObject {
    
    
    static let api_URL = "http://data.fixer.io/api"
    
    public enum servicios:String{
        case WSTimeSeries = "timeseries"
    }
    
    static func getdateURL(date: String) -> String?
    {
        
        var requestURL: String
        
        requestURL = api_URL + "/\(date)"
        print("URL COMPLETA: \(requestURL)")
        return requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
    }
    
    static func getURL(_ method: servicios) -> String?
    {
        
        let methodName =  method.rawValue
        if methodName == ""
        {
            return nil
        }
        
        var requestURL: String
        
        requestURL = api_URL + "/\(methodName)"
        print("URL COMPLETA: \(requestURL)")
        return requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
    }
    
    static func isConnectedToInternet()->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
