//
//  NanoTabbarItemView.swift
//  NanoTabBar
//
//  Created by Nikolay Aksenov on 10.07.17.
//  Copyright © 2017 Nikolay Aksenov. All rights reserved.
//

import UIKit

class NanoTabbarItemView: UIView {
    let item: NanoTabBarItem
    let iconView = UIImageView()

    private var selected = false

    override var tintColor: UIColor! {
        didSet {
            if self.selected {
                self.iconView.tintColor = self.tintColor
            }
        }
    }

    init(_ item: NanoTabBarItem) {
        self.item = item
        super.init(frame: CGRect.zero)

        if let customView = self.item.customView {
            assert(self.item.icon == nil, "Don't set title / icon when using a custom view")
            assert(customView.frame.width > 0 && customView.frame.height > 0, "Custom view must have a width & height > 0")
            self.addSubview(customView)
        } else {
            assert(self.item.icon != nil, "Title / Icon not set")

            if let icon = self.item.icon {
                iconView.image = icon.withRenderingMode(.alwaysTemplate)
                self.addSubview(iconView)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let customView = self.item.customView {
            customView.center = CGPoint(x: self.frame.width / 2 + self.item.offset.horizontal,
                                        y: self.frame.height / 2 + self.item.offset.vertical)
        } else {
            iconView.frame = CGRect(x: self.frame.width / 2 - 13, y: 12, width: 26, height: 20)
        }
    }

    func setSelected(_ selected: Bool, animated: Bool = true) {
        self.selected = selected
        self.iconView.tintColor = selected ? self.tintColor : UIColor(white: 0.6, alpha: 1.0)
    }
}
