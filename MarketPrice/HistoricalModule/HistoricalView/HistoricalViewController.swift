//
//  HistoricalViewController.swift
//  MarketPrice
//
//  Created Emiliano Alfredo Martinez Vazquez on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Charts

class HistoricalViewController: UIViewController,HistoricalViewControllerProtocol {
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    var presenter: HistoricalPresenterProtocol?
    
    override func viewDidLoad() {
        let parametros = HistoricalParameters()
        parametros.startDate = "2020-01-01"
        parametros.endDate = "2020-01-10"
        parametros.symbol = "USD,EUR"
        self.presenter?.loadHistorical(parametros: parametros)
        self.initialStateBar()
    }
    
    func setChart(dataPoints: [String], values: [Float]) {
          
        var dataEntries: [BarChartDataEntry] = []
                
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(values[i]), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
                
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "EUR, USD")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = ChartColorTemplates.colorful()
        barChartView.backgroundColor = .lightGray
        barChartView.data = chartData
    }
    
    func initialStateBar(){
        barChartView.noDataText = "You need to provide data for the chart."
    }
    
    func showHistorical(rates: moneyFormat?){
        let dataPoints = ["EUR","USD"]
        let rates = [rates?.EUR ?? 0, rates?.USD ?? 0]
        setChart(dataPoints: dataPoints, values: rates)
    }
    
    func alertLocation(tit: String, men: String, completion: ((UIAlertAction) -> Void)?)  {
        let alerta = UIAlertController(title: tit, message: men,preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: completion)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
}


