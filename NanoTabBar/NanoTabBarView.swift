//
//  NanoTabBarView.swift
//  NanoTabBar
//
//  Created by Nikolay Aksenov on 10.07.17.
//  Copyright © 2017 Nikolay Aksenov. All rights reserved.
//

import UIKit

public protocol NanoTabBarDelegate: class {
    func tabSelected(_ index: Int)
}

public class NanoTabBarView: UIView {

    public weak var delegate: NanoTabBarDelegate?
    public let keyLine = UIView()
    public override var tintColor: UIColor! {
        didSet {
            for itv in self.itemViews {
                itv.tintColor = self.tintColor
            }
        }
    }

    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight)) as UIVisualEffectView
    public var backgroundBlurEnabled: Bool = true {
        didSet {
            self.visualEffectView.isHidden = !self.backgroundBlurEnabled
        }
    }

    fileprivate var itemViews = [NanoTabbarItemView]()
    fileprivate var currentSelectedIndex: Int?

    public init(items: [NanoTabBarItem]) {
        super.init(frame: CGRect.zero)

        self.backgroundColor = UIColor(white: 1.0, alpha: 0.8)

        self.addSubview(visualEffectView)

        keyLine.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(keyLine)

        var i = 0
        for item in items {
            let itemView = NanoTabbarItemView(item)
            itemView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NanoTabBarView.itemTapped(_:))))
            self.itemViews.append(itemView)
            self.addSubview(itemView)
            i += 1
        }

        self.selectItem(0, animated: false)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        visualEffectView.frame = self.bounds
        keyLine.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)

        let itemWidth = self.frame.width / CGFloat(self.itemViews.count)
        for (i, itemView) in self.itemViews.enumerated() {
            let x = itemWidth * CGFloat(i)
            itemView.frame = CGRect(x: x, y: 0, width: itemWidth, height: frame.size.height)
        }
    }

    func itemTapped(_ gesture: UITapGestureRecognizer) {
        let itemView = gesture.view as! NanoTabbarItemView
        let selectedIndex = self.itemViews.index(of: itemView)!
        self.selectItem(selectedIndex)
    }

    public func selectItem(_ selectedIndex: Int, animated: Bool = true) {
        if !self.itemViews[selectedIndex].item.selectable {
            return
        }
        if (selectedIndex == self.currentSelectedIndex) {
            return
        }
        self.currentSelectedIndex = selectedIndex

        for (index, v) in self.itemViews.enumerated() {
            v.setSelected((index == selectedIndex), animated: animated)
        }

        self.delegate?.tabSelected(selectedIndex)
    }
}
