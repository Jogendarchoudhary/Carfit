//
//  DayCell.swift
//  Calendar
//
//  Test Project
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weekday: UILabel!
    
    var calendarDate: Date? {
        didSet {
            if let date = calendarDate {
                day.text = date.day
                weekday.text = date.weekDay
                if date.isToday {
                    self.isSelected = true
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dayView.layer.cornerRadius = self.dayView.frame.width / 2.0
        self.dayView.backgroundColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dayView.backgroundColor = .daySelected
            } else {
                dayView.backgroundColor = .clear
            }
        }
    }
}
