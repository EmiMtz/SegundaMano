//
//  HistoricalPresenter.swift
//  MarketPrice
//
//  Created Emiliano Alfredo Martinez Vazquez on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HistoricalPresenter: NSObject, HistoricalPresenterProtocol {
    
    weak var view: HistoricalViewControllerProtocol?
    var interactor: HistoricalInteractorProtocol?
    var router: HistoricalRouterProtocol?

    func loadHistorical(parametros: HistoricalParameters) {
        view?.parent?.showIndicator()
     
        interactor?.getHistorical(parametros: parametros, completion: { (historico, error) in
            self.view?.parent?.hideIndicator()
            if error != nil{
                self.view?.alertLocation(tit: "Error", men: (error?.userInfo["message"] as! String), completion: { (alert: UIAlertAction!) in
                    self.loadHistorical(parametros: parametros)
                })
            }else{
                let historical = historico?.rates
                self.view?.showHistorical(rates: historical)
            }
            
        })
    }
    
}
extension HistoricalPresenter: HistoricalInteractorOutputProtocol {
    
}
