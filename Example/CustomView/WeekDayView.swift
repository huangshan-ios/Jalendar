//
//  WeekDayView.swift
//  CalendarViewProject
//
//  Created by MacPro141 on 5/11/19.
//  Copyright © 2019 CalendarView. All rights reserved.
//

import UIKit

class WeekDayView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        _ = loadViewFromNib()
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setTitle(_ string: String) {
        dayLabel.text = string
    }

}
