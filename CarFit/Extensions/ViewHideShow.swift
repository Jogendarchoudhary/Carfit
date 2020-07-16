//
//  ViewHideShow.swift
//  CarFit
//
//  Created by AA/MP/05 on 15/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import UIKit

extension UIView {
    func hideWithAnimation(hidden: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }
}
