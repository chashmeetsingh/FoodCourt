//
//  LeftAlignedIconButton.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

@IBDesignable
class LeftAlignedIconButton: MDCButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = imageEdgeInsets.right + imageEdgeInsets.left + imageSize.width
        return titleRect.offsetBy(dx: availableWidth, dy: 0)
    }
}
