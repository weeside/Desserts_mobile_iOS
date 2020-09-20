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
    static let maxValueLineHeight = 0.3
    static let lineWidth: Double = 330
    
    // animation용 variables
//    static let dataDivisor = Double(maxValue/maxValueLineHeight)
//    static let adjustedData: [Double] = thisWeek.map({ $0.rate / dataDivisor })
//    static var animations: [Animation] = []
    
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
            
            let valueLine = Line(-5, y, lineWidth, y).stroke(fill:Color.gray.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max
                                 , baseline: .mid, place: .move(-10, y))
            valueText.fill = Color.gray
            
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        // y축 선
//        let yAxis = Line(0, 0, 0, yAxisHeight).stroke(fill:Color.gray.with(a: 0.25))
//        newNodes.append(yAxis)
        
        return newNodes
    }
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...thisWeek.count {
            let x = (Double(i)) * 50
            let valueText = Text(text: thisWeek[i - 1].weekday, align: .max, baseline: .mid, place: .move(x - 25, chartBaseY + 15))
            valueText.fill = Color.gray
            newNodes.append(valueText)
        }
        
        let xAxis = Line(0, chartBaseY, lineWidth, chartBaseY).stroke(fill:Color.gray.with(a: 0.25))
        newNodes.append(xAxis)
        return newNodes
    }
    
    private static func createBars() -> [Shape] {
        // animation 구현하다가 시뮬레이터에서 계속 깨져서 코멘트 처리해둠
//        let items = adjustedData.map { _ in Group() }
        
//        print("createBars starting")
//        animations = items.enumerated().map { (i: Int, item: Group) in
//            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
//                let height = thisWeek[i].rate * 20 * t
//                let rect = Rect(Double(i) * 50 + 10, 200 - height, 30, height * 100)
//                return [rect.fill(with: fill)]
//            }
//        }
        
        var rects: [Shape] = []
        for i in 0...6 {
            let rect = Rect(Double(i) * 50 + 5, 200 - thisWeek[i].rate * 20, 25, thisWeek[i].rate * 20)
            
            var fillColor = Color.clear
            switch thisWeek[i].rate {
            case 0..<2:
                fillColor = Color(0xffc7d2)
            case 2..<4:
                fillColor = Color(0xffb77c)
            case 4..<6:
                fillColor = Color(0xc4f098)
            case 6...10:
                fillColor = Color(0xb5dcf2)
            default:
                fillColor = Color.clear
            }
            
            rects.append(rect.fill(with: fillColor))
        }
        
//        return items.group()
        return rects
    }
    
    
//    static func playAnimations() {
//        animations.combine().play()
//        print("animation played")
//    }
    
    
    private static func createDummyData() -> [WeeklyChart] {
        let one = WeeklyChart(weekday: "월", rate: 3.0)
        let two = WeeklyChart(weekday: "화", rate: 1.9)
        let three = WeeklyChart(weekday: "수", rate: 5.2)
        let four = WeeklyChart(weekday: "목", rate: 10.0)
        let five = WeeklyChart(weekday: "금", rate: 1.1)
        let six = WeeklyChart(weekday: "토", rate: 4.3)
        let seven = WeeklyChart(weekday: "일", rate: 8.0)
        
        return [one, two, three, four, five, six, seven]
    }
}
