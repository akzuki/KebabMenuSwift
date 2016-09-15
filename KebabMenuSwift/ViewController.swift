//
//  ViewController.swift
//  KebabMenuSwift
//
//  Created by Hai Phan on 9/15/16.
//  Copyright © 2016 Hai Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menuLauncher: MenuLauncher!
    let menuDataSource: [Menu] = [
        Menu(menuImage: "refresh_icon", menuLabel: "Refresh"),
        Menu(menuImage: "map_icon", menuLabel: "Map"),
        Menu(menuImage: "mail_icon", menuLabel: "Mail"),
        Menu(menuImage: "notification_icon", menuLabel: "Notifications"),
        Menu(menuImage: "help_icon", menuLabel: "Help & Feedback"),
        Menu(menuImage: "settings_icon", menuLabel: "Settings"),
        Menu(menuImage: "logout_icon", menuLabel: "Sign out"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLauncher = MenuLauncher(withDataSource: menuDataSource)
        menuLauncher.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showKebabMenu(sender: UIBarButtonItem) {
        menuLauncher.showMenu(withAnimation: .DropDown)
    }
}

extension ViewController: KebabMenuSwiftDelegate {
    func didSelectMenuAtIndexPath(indexPath: Int) {
        switch indexPath {
        case 0:
            print("Refresh icon clicked")
        //Do something here
        case 1:
            print("Mail icon clicked")
        default:
            break
        }
    }

}

