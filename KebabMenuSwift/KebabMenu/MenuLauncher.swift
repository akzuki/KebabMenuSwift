//
//  MenuLauncher.swift
//  KebabMenuSwift
//
//  Created by Hai Phan on 8/18/16.
//  Copyright © 2016 Hai Phan. All rights reserved.
//

import Foundation
import UIKit

enum AnimationType {
    case Default
    case PopOver
    case DropDown
}

protocol KebabMenuSwiftDelegate: class {
    func didSelectMenuAtIndexPath(indexPath: Int)
}

class MenuLauncher: NSObject {
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        return backgroundView
    }()
    
    private let menu: UITableView = {
        let menuTableView = UITableView()
        menuTableView.rowHeight = 60
        menuTableView.scrollEnabled = false
        menuTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 1))
        return menuTableView
    }()
    
    weak var delegate: KebabMenuSwiftDelegate?
    
    private let cellHeight: CGFloat = 60
    private let menuCellIdentifier: String = "MenuCell"
    private let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    private var menuHeight: CGFloat = 0
    private var animationType: AnimationType = .Default
    
    private var menuDataSource: [Menu]!
    
    private override init() {
        super.init()
    }
    
    init(withDataSource menuDataSource: [Menu]) {
        super.init()
        menu.dataSource = self
        menu.delegate = self
        self.menuDataSource = menuDataSource
        menu.registerNib(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: menuCellIdentifier)
        menu.layer.cornerRadius = 5
        menu.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.3).CGColor
        menu.layer.borderWidth = 1
        
        menuHeight = CGFloat(menuDataSource.count) * cellHeight
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    func setBorder(radius radius: CGFloat, color: UIColor, borderWidth: CGFloat) {
        menu.layer.cornerRadius = radius
        menu.layer.borderColor = color.CGColor
        menu.layer.borderWidth = borderWidth
    }
    
    func showMenu(withAnimation animation: AnimationType = .Default) {
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(menu)
            backgroundView.frame = window.frame
            animationType = animation
            switch animation {
            case .Default:
                showMenuWithDefaultAnimation()
            case .PopOver:
                showMenuWithPopOverAnimation()
            case .DropDown:
                showMenuWithDropDownAnimation()
            }
        }
    }
    
    func handleDismiss() {
        switch animationType {
        case .Default:
            dismissMenuWithDefaultAnimation()
        case .PopOver:
            dismissMenuWithPopOverAnimation()
        case .DropDown:
            dismissMenuWithDropDownAnimation()
        }
    }
    
    private func showMenuWithDefaultAnimation() {
        self.menu.alpha = 0
        self.backgroundView.alpha = 0
        menu.frame = CGRectMake(screenWidth - 200 - 20 , 50, 200, menuHeight)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.menu.alpha = 1
            self.backgroundView.alpha = 1
            }, completion: nil)
    }
    
    private func dismissMenuWithDefaultAnimation() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.menu.alpha = 0
            self.backgroundView.alpha = 0
        }) { completed in
            if UIApplication.sharedApplication().keyWindow != nil {
                self.backgroundView.removeFromSuperview()
                self.menu.removeFromSuperview()
            }
        }
    }
    
    private func showMenuWithPopOverAnimation() {
        self.menu.alpha = 1
        self.backgroundView.alpha = 0
        menu.frame = CGRectMake(screenWidth - 200 - 20 + 200/2, 50 + menuHeight/2, 0, 0)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.backgroundView.alpha = 1
            self.menu.frame = CGRectMake(self.screenWidth - 200 - 20 , 50, 200, self.menuHeight)
            }, completion: nil)
    }
    
    private func dismissMenuWithPopOverAnimation() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.backgroundView.alpha = 0
            self.menu.frame = CGRectMake(self.screenWidth - 200 - 20 + 200/2, 50 + self.menuHeight/2, 0, 0)
        }) { completed in
            if UIApplication.sharedApplication().keyWindow != nil {
                self.backgroundView.removeFromSuperview()
                self.menu.removeFromSuperview()
            }
        }
    }
    
    private func showMenuWithDropDownAnimation() {
        self.menu.alpha = 1
        self.backgroundView.alpha = 0
        menu.frame = CGRectMake(screenWidth - 200 - 20, 50, 200, 0)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.backgroundView.alpha = 1
            self.menu.frame = CGRectMake(self.screenWidth - 200 - 20, 50, 200, self.menuHeight)
            }, completion: nil)
    }
    
    private func dismissMenuWithDropDownAnimation() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { [unowned self] _ in
            self.backgroundView.alpha = 0
            self.menu.frame = CGRectMake(self.screenWidth - 200 - 20, 50, 200, 2)
        }) { completed in
            if UIApplication.sharedApplication().keyWindow != nil {
                self.backgroundView.removeFromSuperview()
                self.menu.removeFromSuperview()
            }
        }
    }
}

extension MenuLauncher: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(menuCellIdentifier, forIndexPath: indexPath) as! MenuCell
        let menuForRow = menuDataSource[indexPath.row]
        cell.configure(menuForRow)
        return cell
    }
}

extension MenuLauncher: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        handleDismiss()
        self.delegate?.didSelectMenuAtIndexPath(indexPath.row)
    }
}