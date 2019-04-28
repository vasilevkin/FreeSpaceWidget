//
//  Constants.swift
//  freespacewidget
//
//  Created by Sergey Vasilevkin on 28/04/2019.
//  Copyright © 2019 Sergey Vasilevkin. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

// MARK: - Constants

struct Constants {

    static let samplerUpdateInterval: RxTimeInterval = 10  // How often update data in model, in seconds

    let colorProgressViewBackground = UIColor(red: 0.0/255.0, green: 192.0/255.0, blue: 0.0/255.0, alpha: 0.7)
    let colorProgressViewFont = UIColor.white
    let colorProgressViewProgress = UIColor(red: 0.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    let colorProgressViewEmptyLine = UIColor(red: 0.0/255.0, green: 255.0/255.0, blue: 128.0/255.0, alpha: 1.0)

    let sizeProgressViewCornerRadius: CGFloat = 3
    let sizeProgressViewProgressLineWidth: CGFloat = 4
    let sizeProgressViewEmptyLineWidth: CGFloat = 3

    let sizeWidgetCompactSizeFont = UIFont.systemFont(ofSize: 14)
    let sizeWidgetExpandedSizeFont = UIFont.systemFont(ofSize: 20)
    let sizeDescriptionLabelFont: CGFloat = 15

    let nameWidgetCircularProgressValueFont: String = "Helvetica Bold"

}
