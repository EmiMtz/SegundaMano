//
//  HistoricalEntity.swift
//  MarketPrice
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/04/21.
//

import Foundation

class HistoricalParameters: Encodable{
    //var key: String?
    var startDate: String?
    var endDate: String?
    var symbol: String?
    
    
    /// Convertir a string los parametros
    /// - Returns: un string con los arreglos acomodados
    func convertToString() -> String{
        var strParams = "?access_key=\(Constants.fixerApiKey)"
        
        if let startDate = startDate{
            strParams += "&start_date=\(startDate)"
        }
        if let endDate = endDate{
            strParams += "&end_date=\(endDate)"
        }
        
        if let symbol = symbol{
            strParams += "&symbols=\(symbol)"
        }
        
        return strParams
    }
    
}

class responseHistorical: Codable {
    var success: Bool?
    var historical: Bool?
    var date: String?
    var timestamp: Int?
    var rates: moneyFormat?
}

class moneyFormat: Codable {
    var USD: Float
    var EUR: Float
}
