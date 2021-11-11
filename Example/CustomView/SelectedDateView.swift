//
//  SelectedDateView.swift
//  CalendarViewProject
//
//  Created by MacPro141 on 5/11/19.
//  Copyright © 2019 CalendarView. All rights reserved.
//

import UIKit

class SelectedDateView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.borderWidth = 4 * 0.5
        layer.borderColor = UIColor.gray.cgColor
    }
    
}
