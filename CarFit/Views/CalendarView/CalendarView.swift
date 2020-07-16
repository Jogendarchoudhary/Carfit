//
//  CalendarView.swift
//  Calendar
//
//  Test Project
//

import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: String)
    func updateTitleWith(_ date: String)
}

class CalendarView: UIView {

    @IBOutlet weak var monthAndYear: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    
    //current selectd date
    var currentDate:Date = Date() {
        didSet {
            if currentDate.getDateWithYear() == Date().getDateWithYear() {
                delegate?.updateTitleWith("Today")
            } else {
                delegate?.updateTitleWith(currentDate.getDateWithYear())
            }
        }
    }
    
    //current selectd month
    var currentMonth:Date = Date().startOfMonth
    
    // current month all dates
    var allDates = Date().getAllDates() {
        didSet {
            monthAndYear.text = currentMonth.getMonthAndYear()
            daysCollectionView.reloadData()
        }
    }

    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.daysCollectionView.register(nib, forCellWithReuseIdentifier: self.cellID)
        self.daysCollectionView.delegate = self
        self.daysCollectionView.dataSource = self
        monthAndYear.text = currentMonth.getMonthAndYear()
        scrollToCurrentDate()
    }
    
    //MARK:- Change month when left and right arrow button tapped
    @IBAction func arrowTapped(_ sender: UIButton) {
        switch sender {
        case leftBtn:
            currentMonth = currentMonth.previousMonth()
        default:
            currentMonth = currentMonth.nextMonth()
        }
        allDates = currentMonth.getAllDates()
        scrollToCurrentDate()
    }
    
    func scrollToCurrentDate() {
        var indexPath = IndexPath(item: 0, section: 0)
        if currentMonth.isCurrentMonth {
            indexPath = IndexPath(item: Date().dayInInt - 1, section: 0)
        } else if currentMonth.isSelectedMonth(date: currentDate) {
            indexPath = IndexPath(item: currentDate.dayInInt - 1, section: 0)
        }
        daysCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

//MARK:- Calendar collection view delegate and datasource methods
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! DayCell
        let date = allDates[indexPath.row]
        cell.calendarDate = date
        if date.string == currentDate.string {
            cell.isSelected  = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var preSelectedItem:IndexPath?
        if let index = allDates.firstIndex(of: self.currentDate) {
            // index path for pre selected date
            preSelectedItem = IndexPath(item: index, section: 0)
        }
        let date = allDates[indexPath.row]
        self.currentDate = date
        delegate?.getSelectedDate(date.string)
        if let preSelected = preSelectedItem {
            // Reloading the preselected item because when we select cell programmetically then "didDeselectItemAt:" method will not getting call
            collectionView.reloadItems(at: [preSelected])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let date = allDates[indexPath.row]
        if date.isToday {
            return false
        }
        return true
    }
}

//MARK:- Add calendar to the view
extension CalendarView {
    
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
    
}
