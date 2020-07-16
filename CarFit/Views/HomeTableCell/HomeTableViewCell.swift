//
//  HomeTableViewCell.swift
//  Calendar
//
//  Test Project
//

import UIKit
import CoreLocation

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var customer: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tasks: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var timeRequired: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var previousWorkOrder: WorkOrders?
    var workOrder: WorkOrders? {
        didSet {
            if let order = workOrder {
                customer.text = order.fullName()
                status.text = order.visitState.map { $0.rawValue }
                tasks.text = order.getTitle()
                arrivalTime.text = order.getTime()
                destination.text = order.fullAddress()
                timeRequired.text = "\(order.totalTimeInMinutes())"
                statusView.backgroundColor = order.visitState?.color()
                if let preLoc = previousWorkOrder?.location(), let currentLoc = order.location() {
                    distance.text = String(format: "%.2f km", preLoc.distance(from: currentLoc)/1000)
                } else {
                    distance.text = "0 KM"
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 10.0
        self.statusView.layer.cornerRadius = self.status.frame.height / 2.0
        self.statusView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

}
