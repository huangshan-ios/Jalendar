//
//  View+Extensions.swift
//  Example
//
//  Created by Son Hoang on 12/11/2021.
//

import UIKit

extension UIView {
    public class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    public class func loadNib<T: UIView>() -> T! {
        let name = String(describing: self)
        let bundle = Bundle(for: T.self)
        guard let xib = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
            fatalError("Cannot load nib named `\(name)`")
        }
        return xib
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return UIView()
        }
        return view
    }
}
