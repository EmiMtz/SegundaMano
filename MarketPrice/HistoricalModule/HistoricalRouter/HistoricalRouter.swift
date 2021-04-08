//
//  HistoricalRouter.swift
//  MarketPrice
//
//  Created Emiliano Alfredo Martinez Vazquez on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HistoricalRouter: HistoricalRouterProtocol {
    
    weak var presenter: HistoricalPresenterProtocol?
    
    static func createModule() -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "Historical") as! HistoricalViewControllerProtocol
        let presenter: HistoricalPresenterProtocol & HistoricalInteractorOutputProtocol = HistoricalPresenter()
        let interactor:HistoricalInteractorProtocol = HistoricalInteractor()
        var router: HistoricalRouterProtocol = HistoricalRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "HistoricalStoryboard", bundle: nil)
    }
}
