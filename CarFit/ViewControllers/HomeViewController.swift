//
//  ViewController.swift
//  Calendar
//
//  Test Project
//

import UIKit

class HomeViewController: UIViewController, AlertDisplayer {

    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var calendarView: UIView!
    @IBOutlet weak var calendar: UIView!
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    @IBOutlet weak var workOrderTableView: UITableView!
    @IBOutlet weak var workOrderTableTopConstraint: NSLayoutConstraint!
    
    private let cellID = "HomeTableViewCell"
    private let refreshControl = UIRefreshControl()

    let viewModel = CleanerListViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.configureObserver()
        self.fetchCleanerList()
    }
    
    
    //MARK:- Add calender to view
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendar) {
            calendar.delegate = self
            calendar.currentDate = Date()
        }
    }

    //MARK:- UI setups
    private func setupUI() {
        self.navBar.transparentNavigationBar()
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.workOrderTableView.register(nib, forCellReuseIdentifier: self.cellID)
        self.workOrderTableView.rowHeight = UITableView.automaticDimension
        self.workOrderTableView.estimatedRowHeight = 170
        self.calendarView.isHidden = true
        self.workOrderTableTopConstraint.constant = 0
        self.workOrderTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.touchAction))
        self.workOrderTableView.addGestureRecognizer(gesture)

    }
    
    // Touch action to show/hide calendar
    @objc func touchAction(sender : UITapGestureRecognizer) {
        self.calendarView.hideWithAnimation(hidden: true)
        self.workOrderTableTopConstraint.constant = 0
    }
    
    // This is to refresh the current data, but there is no changes in data so only stop the refreshing
    @objc private func refreshAction(_ sender: Any) {
        refreshControl.endRefreshing()
    }
    
    //MARK:- Show calendar when tapped, Hide the calendar when tapped outside the calendar view
    @IBAction func calendarTapped(_ sender: UIBarButtonItem) {
        self.workOrderTableTopConstraint.constant = 120
        self.calendarView.hideWithAnimation(hidden: false)
    }
}

//MARK: Fetch and update Methods
extension HomeViewController {
    
    func fetchCleanerList() {
        viewModel.fetchCleanerListWith(date: Date().string)
    }
    
    func configureObserver() {
        self.viewModel.listDidChanges = { (flag) in
            if flag {
                self.workOrderTableView.reloadData()
            }
        }
    }
}

//MARK:- Tableview delegate and datasource methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.workOrders?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! HomeTableViewCell
        if let workOrders = viewModel.workOrders {
            cell.previousWorkOrder = indexPath.row == 0 ? nil : workOrders[indexPath.row - 1]
            cell.workOrder = workOrders[indexPath.row]
        }
        return cell
    }
    
}

//MARK:- Get selected calendar date
extension HomeViewController: CalendarDelegate {
    
    func getSelectedDate(_ date: String) {
        viewModel.fetchCleanerListWith(date: date)
    }
    
    func updateTitleWith(_ date: String) {
        navBar.topItem?.title = date
    }
}
