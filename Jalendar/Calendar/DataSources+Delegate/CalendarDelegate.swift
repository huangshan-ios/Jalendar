//
//  CalendarDelegate.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public protocol CalendarDelegate {
    
    func tap(at date: Date, index: ItemViewIndex, point: CGPoint)
    
    func doubleTap(at date: Date, index: ItemViewIndex, point: CGPoint)
    
    func longPress(at date: Date, index: ItemViewIndex, point: CGPoint)
    
}

extension CalendarDelegate {
    
    func tap(at date: Date, index: ItemViewIndex, point: CGPoint) {}
    
    func doubleTap(at date: Date, index: ItemViewIndex, point: CGPoint) {}
    
    func longPress(at date: Date, index: ItemViewIndex, point: CGPoint) {}
    
}
