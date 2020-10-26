//
//  MonthlyViewController.swift
//  Desserts
//
//  Created by 김예랑 on 2020/09/25.
//  Copyright © 2020 김예랑. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

class MonthlyViewController: UIViewController {
    
//    var formatter = DateFormatter()
    let sampleData = ["2020-10-21": 10, "2020-10-10": 1, "2020-10-30": 3, "2020-10-13": 5, "2020-10-23": 7]
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
    }()
    
    @IBOutlet var monthlyCommentLabel: UILabel!
    @IBOutlet var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 하단 string은 API에서 받아오는 것으로 교체될 예정
        let attributedString = NSMutableAttributedString(
            string: "요 며칠\n우울해 보였는데 😢\n오늘은 기분이 좋아 보여서\n다행이에요. ☺️",
            attributes: [
                .font: UIFont(name: "SpoqaHanSans-Bold", size: 32.0)!,
                .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        monthlyCommentLabel.attributedText = attributedString
        
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.today = nil
        calendar.scrollDirection = .horizontal
//        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .clear
        
        // Header
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayTextColor = .opaqueSeparator
        
    }
    
    @IBAction func weekButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "monthlyToWeekly", sender: self)
    }

}

extension MonthlyViewController: FSCalendarDataSource {

    
}

extension MonthlyViewController: FSCalendarDelegate {
    

}

extension MonthlyViewController: FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let pink = dataToArray(sampleData)[0]
        let orange = dataToArray(sampleData)[1]
        let green = dataToArray(sampleData)[2]
        let blue = dataToArray(sampleData)[3]
        
        let dateString : String = dateFormatter1.string(from:date)

        if pink.contains(dateString) {
            return K.BrandColors.pink
        } else if orange.contains(dateString) {
            return K.BrandColors.orange
        } else if green.contains(dateString) {
            return K.BrandColors.green
        } else if blue.contains(dateString) {
            return K.BrandColors.blue
        } else {
            return nil
        }
    }

func dataToArray(_ monthlyData: [String:Int]) -> [Array<String>] {
    var pink : [String] = [""]
    var orange : [String] = [""]
    var green : [String] = [""]
    var blue : [String] = [""]
    for (key, value) in monthlyData {
        switch value {
        case 0..<2:
            pink.append(key)
        case 2..<4:
            orange.append(key)
        case 4..<6:
            green.append(key)
        case 6...10:
            blue.append(key)
        default:
            pink.append(key)
        }
    }
    return [pink, orange, green, blue]
}
    
}



