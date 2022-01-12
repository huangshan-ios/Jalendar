//
//  DateView.swift
//  CalendarViewProject
//
//  Created by MacPro141 on 5/11/19.
//  Copyright © 2019 CalendarView. All rights reserved.
//

import UIKit

class DateView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var dateTitleLabel: UILabel!
    
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
    
    func configCell(date: Date) {
        dateTitleLabel.text = "\(date.day)"
    }

}
