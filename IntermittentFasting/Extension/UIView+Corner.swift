//
//  UIView+Corner.swift
//  IntermittentFasting
//
//  Created by Byunsangjin on 10/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
