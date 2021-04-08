//
//  ViewController.swift
//  MarketPrice
//
//  Created by Emiliano Alfredo Martinez Vazquez on 06/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = HistoricalRouter.createModule()
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.isNavigationBarHidden = true
        
        self.navigationController?.present(nav, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }


}

