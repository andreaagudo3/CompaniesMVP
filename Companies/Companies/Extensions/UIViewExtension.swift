//
//  UIViewExtension.swift
//  Companies
//
//  Created by Andrea Agudo on 22/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

extension UIView {
    func setCustomizedShadow(opacity: Float = 0.2, shadowRadius: CGFloat = 2, cornerRadius: CGFloat = 10) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
        self.layer.cornerRadius = cornerRadius
    }
}
