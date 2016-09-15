# KebabMenuSwift

`KebabMenuSwift` is a lightweighted, customizable and easy to use to add kebab menu to your iOS project.
`KebabMenuSwift` supports images also provides animations to display the menu.

## Screenshots

![alt tag](https://github.com/akzuki/KebabMenuSwift/blob/master/GIF/ezgif-1215024276.gif)

## Installation
....

##Usage
`KebabMenuSwift` is very easy to use. Just prepare an array of your items that will be shown in the menu, create `MenuLauncher` in your ViewController, set `delegate` for the `MenuLauncher` and you're ready to go.
Make sure your ViewController adopts and conforms `KebabMenuSwiftDelegate`


```Swift
var menuLauncher: MenuLauncher!
let menuDataSource: [Menu] = [
      Menu(menuImage: "refresh_icon", menuLabel: "Refresh"), //icon and label for menu options
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

```

####To show menu
Just call `showMenu(withAnimation: )`. 

```Swift
menuLauncher.showMenu(withAnimation: .DropDown)
//or just call 
menuLauncher.showMenu() //Default animation
```

Animations to choose:

`.Default`
![alt tag](https://github.com/akzuki/KebabMenuSwift/blob/master/GIF/ezgif-710829181.gif)

`.PopOver`
![alt tag](https://github.com/akzuki/KebabMenuSwift/blob/master/GIF/ezgif-2661895881.gif)

`.DropDown`
![alt tag](https://github.com/akzuki/KebabMenuSwift/blob/master/GIF/ezgif-1215024276.gif)

###Handle click on menu options
Make sure your ViewController adopts and conforms `KebabMenuSwiftDelegate`

```Swift
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

```

###Customize menu
####Custom UI:
`func setBorder(radius radius: CGFloat, color: UIColor, borderWidth: CGFloat)`

####Custom Animation:
...



