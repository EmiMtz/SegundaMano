//
//  HistoricalInteractor.swift
//  MarketPrice
//
//  Created Emiliano Alfredo Martinez Vazquez on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HistoricalInteractor: NSObject, HistoricalInteractorProtocol {
    
    weak var output: HistoricalInteractorOutputProtocol?
    
    func getHistorical(parametros: HistoricalParameters, completion: @escaping (responseHistorical?, NSError?) -> Void) {
        let urlServicio = WebRequests.getdateURL(date: "2021-01-01")! + parametros.convertToString()
        
        RequestManager.make(url: urlServicio, metodo: .get) { (responseData: responseHistorical?, code: CodeResponse?, tag: Int) in
            var errorWS : NSError? = nil
            var response : responseHistorical? = nil
            switch code{
            case .ok:
                response = responseData
            default:
                errorWS = NSError(domain:"WSGoogle", code:-1,userInfo: ["message": "El servicio no está disponible, por favor intente más tarde."])
                
            }
            completion(response,errorWS)
        }
    }
    
}
