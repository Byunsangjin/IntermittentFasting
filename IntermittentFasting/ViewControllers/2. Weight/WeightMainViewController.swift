//
//  WeightPageViewController.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 30/04/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit
import Charts

class WeightMainViewController: UIViewController, ChartViewDelegate {
    // MARK:- Outlets
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var weightLabel: UILabel!
    
    
    
    // MARK:- Variables
    
    
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        chartView.chartDescription?.enabled = false
        
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.legend.enabled = false
        
        chartView.rightAxis.enabled = false
        
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 1)
        
        
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaximum = 90
        leftAxis.axisMinimum = leftAxis.axisMaximum - 30
        
        leftAxis.enabled = false
        leftAxis.gridLineWidth = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        
        let xAxis = chartView.xAxis
        xAxis.axisMinimum = 1
        xAxis.axisMaximum = 30
        xAxis.labelPosition = .bottom
        
        xAxis.gridLineWidth = 0
        
        xAxis.labelCount = 6
        
        let xAxisFomatter = NumberFormatter()
        xAxisFomatter.minimumFractionDigits = 0
        xAxisFomatter.maximumFractionDigits = 0
        xAxisFomatter.negativeSuffix = "일"
        xAxisFomatter.positiveSuffix = "일"
        
        
        
        xAxis.valueFormatter =  DefaultAxisValueFormatter(formatter: xAxisFomatter)
        
        setDataCount(30, range: 0)
        
        let marker = XYMarkerView(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8), xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        for set in chartView.data!.dataSets as! [LineChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
        }
        
        
        
        self.titleLabel.text = Date().dateToString()
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (1...count).map { (i) -> ChartDataEntry in
            let val = Int.random(in: 70...80)
            return ChartDataEntry(x: Double(i), y: Double(val))
        }
        
        let set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
        set1.drawCirclesEnabled = false
        set1.lineWidth = 0
        set1.circleRadius = 3
        set1.fillAlpha = 1
        set1.drawFilledEnabled = true
        
        let gradientColors = [ChartColorTemplates.colorFromString("#ffffff").cgColor,
                              ChartColorTemplates.colorFromString("#4DB6D7").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        //        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            
            set1.setDrawHighlightIndicators(false)
            return CGFloat(self.chartView.leftAxis.axisMinimum)
        }
        
        let data = LineChartData(dataSets: [set1])
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
    
    
    // MARK:- Actions
    @IBAction func calendarBtnClick(_ sender: Any) {
//        CalendarManager.curSelectedDay = CalendarManager.getTodayIndex()
//        CalendarManager.newSelectedDay = CalendarManager.curSelectedDay
        
        let popupVC = CalendarPopup.calendarPopup()
        popupVC.addActionConfirmClick { (year, month, day) in
            self.titleLabel.text = "\(year)년 \(month)월 \(day)일"
            // 화면 갱신
//            self.updateScreen()
        }
    }
    
    
    
    @IBAction func addWeightBtnClick(_ sender: Any) {
        let addWeightAlertVC = self.storyboard?.instantiateViewController(withIdentifier: "AddWeightAlertViewController") as! AddWeightAlertViewController
        
        self.addChild(addWeightAlertVC)
        self.view.addSubview(addWeightAlertVC.view)
    }
    
}

public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(Int(value))
        return months[Int(value)]
    }
}
