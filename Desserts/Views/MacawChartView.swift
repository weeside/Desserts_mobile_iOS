//
//  MacawChartView.swift
//  Desserts
//
//  Created by 김예랑 on 2020/09/18.
//  Copyright © 2020 김예랑. All rights reserved.
//

import Foundation
import Macaw

class MacawChartView: MacawView {
    
    static let thisWeek = createDummyData()
    static let maxValue = 10.0
    static let lineWidth: Double = 360

    required init?(coder aDecoder: NSCoder) {
        super.init(node: MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = .clear
    }
    
    private static func createChart() -> Group {
        let items: [Node] = addYAxisItems() + addXAxisItems() + createBars()
        
        return Group(contents: items, place: .identity)
    }
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 5
        let lineInterval = 2
        
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 40
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(25, y + 5, lineWidth, y)
                .stroke(fill:Color.gray.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)",
                                 align: .max,
                                 baseline: .mid,
                                 place: .move(15, y + 5))
            valueText.fill = Color.gray
            
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        // y축 선
        /* let yAxis = Line(0, 0, 0, yAxisHeight)
            .stroke(fill:Color.gray.with(a: 0.25))
        newNodes.append(yAxis) */

        return newNodes
    }
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...thisWeek.count {
            let x = (Double(i)) * 50
            let valueText = Text(text: thisWeek[i - 1].weekday,
                                 align: .max,
                                 baseline: .mid,
                                 place: .move(x, chartBaseY + 15))
            valueText.fill = Color.gray
            newNodes.append(valueText)
        }
        
        let xAxis = Line(15, chartBaseY, lineWidth, chartBaseY)
            .stroke(fill:Color.gray.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    private static func createBars() -> [Shape] {
        var rects: [Shape] = []
        
        for i in 0...thisWeek.count - 1 {
            if thisWeek[i].rate != nil {
                let rect = Rect(Double(i) * 50 + 30,
                                200 - thisWeek[i].rate! * 20 + 5,
                                25,
                                thisWeek[i].rate! * 20 - 5)
                let fill = fillColor(thisWeek[i].rate!)
                rects.append(rect.fill(with: fill))
            }
        }
        
        return rects
    }
    
    private static func fillColor(_ rate: Double) -> Color {
        var fill = Color.clear
        
        switch rate {
        case 0..<2:
            fill = Color(K.HexColors.pink)
        case 2..<4:
            fill = Color(K.HexColors.orange)
        case 4..<6:
            fill = Color(K.HexColors.green)
        case 6...10:
            fill = Color(K.HexColors.blue)
        default:
            fill = Color.clear
        }
        
        return fill
    }
    
    private static func createDummyData() -> [WeeklyChart] {
        let one = WeeklyChart(weekday: "월", rate: 3.0)
        let two = WeeklyChart(weekday: "화", rate: 1.9)
        let three = WeeklyChart(weekday: "수", rate: 5.2)
        let four = WeeklyChart(weekday: "목", rate: 10.0)
        let five = WeeklyChart(weekday: "금", rate: nil)
        let six = WeeklyChart(weekday: "토", rate: 4.3)
        let seven = WeeklyChart(weekday: "일", rate: 8.0)
        
        return [one, two, three, four, five, six, seven]
    }
}
