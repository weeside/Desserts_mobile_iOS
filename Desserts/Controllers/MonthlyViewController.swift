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
    
    var formatter = DateFormatter()
    
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
