//
//  NanoTabBarItem.swift
//  NanoTabBar
//
//  Created by Nikolay Aksenov on 10.07.17.
//  Copyright © 2017 Nikolay Aksenov. All rights reserved.
//

import Foundation

public class NanoTabBarItem {

    var icon: UIImage?

    var customView: UIView?

    var offset = UIOffset.zero

    public var selectable: Bool = true

    public init(icon: UIImage?) {
        self.icon = icon
    }

    public init(customView: UIView, offset: UIOffset = UIOffset.zero) {
        self.customView = customView
        self.offset = offset
    }

}
