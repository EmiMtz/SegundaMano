//
//  HistoricalContracts.swift
//  MarketPrice
//
//  Created Emiliano Alfredo Martinez Vazquez on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol HistoricalViewControllerProtocol: UIViewController {
    var presenter: HistoricalPresenterProtocol? {get set}
    func alertLocation(tit: String, men: String, completion: ((UIAlertAction) -> Void)?)
    func showHistorical(rates: moneyFormat?)
}
//Interactor
protocol HistoricalInteractorProtocol: NSObject {
    var output: HistoricalInteractorOutputProtocol? {get set}
    func getHistorical(parametros: HistoricalParameters, completion: @escaping (responseHistorical?, NSError?) -> Void)
}

protocol HistoricalInteractorOutputProtocol: NSObject {

}

//Presenter
protocol HistoricalPresenterProtocol: NSObject {
    var view: HistoricalViewControllerProtocol? {get set}
    var interactor: HistoricalInteractorProtocol? {get set}
    var router: HistoricalRouterProtocol? {get set}

    func loadHistorical(parametros: HistoricalParameters)
}
//Router
protocol HistoricalRouterProtocol {
    var presenter: HistoricalPresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
}

