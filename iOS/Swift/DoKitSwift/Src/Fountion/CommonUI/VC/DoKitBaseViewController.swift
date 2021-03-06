//
//  DoKitBaseViewController.swift
//  AFNetworking
//
//  Created by didi on 2020/5/25.
//

import UIKit

class DoKitBaseViewController: UIViewController, DoKitBaseBigTitleViewDelegate {
    
    var bigTitleView: DoKitBaseBigTitleView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        if self.needBigTitleView() {
            bigTitleView = DoKitBaseBigTitleView(frame: CGRect(x: 0, y: 0, width: view.width, height: kSizeFrom750_Landscape(178)))
            bigTitleView!.delegate = self
            view.addSubview(bigTitleView!)
        }else{
            let image = UIImage.dokitImageNamed(name: "doraemon_back")
            let leftModel = DoKitNavBarItemModel(icon: image, iconSelector: #selector(leftNavBackClick))
            self.setLeftNavBarItems(items: [leftModel])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = self.needBigTitleView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let appWindow : UIWindow? = UIApplication.shared.delegate?.window ?? nil
        let keyWindow : UIWindow? = UIApplication.shared.keyWindow
        if appWindow != nil && keyWindow != nil && appWindow !== keyWindow {
            appWindow!.makeKey()
        }
    }
    
    func needBigTitleView() -> Bool{
        return false
    }
    
    func setTitle(title: String) {
        if bigTitleView != nil {
            bigTitleView!.title = title
        }else{
            super.title = title
        }
    }
    
    
    func setLeftNavBarItems(items: Array<DoKitNavBarItemModel>?) {
        if let items = items {
            let barItems = self.navigationItems(items: items)
            self.navigationItem.leftBarButtonItems = barItems
        }else{
            self.navigationItem.leftBarButtonItems = nil
        }
    }
    
    func setRightNavBarItems(items: Array<DoKitNavBarItemModel>?) {
        if let items = items {
            let barItems = self.navigationItems(items: items)
            self.navigationItem.rightBarButtonItems = barItems
        }else{
            self.navigationItem.rightBarButtonItems = nil
        }
        
    }
    
    func setRightNavTitle(title: String) {
        let item = DoKitNavBarItemModel(title: title, titleColor: UIColor.blue, titleSelector: #selector(rightNavTitleClick))
        let barItems = self.navigationItems(items: [item])
        self.navigationItem.rightBarButtonItems = barItems
    }
    
    func navigationItems(items: Array<DoKitNavBarItemModel>) -> Array<UIBarButtonItem> {
        var barItems: Array<UIBarButtonItem> = [UIBarButtonItem]()
        
        for item in items {
            var barItem: UIBarButtonItem
            if item.type ==  .text{
                barItem = UIBarButtonItem(title: item.text, style: .plain, target: self, action: item.selector)
                barItem.tintColor = item.textColor
            }else if item.type == .image{
                let image = item.image?.withRenderingMode(.alwaysOriginal)
                let btn = UIButton(type: .custom)
                btn.setImage(image, for: .normal)
                btn.addTarget(self, action: item.selector!, for: .touchUpInside)
                btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                btn.clipsToBounds = true
                barItem = UIBarButtonItem(customView: btn)
            }else{
                barItem = UIBarButtonItem()
            }
            barItems.append(barItem)
        }
        return barItems
    }
    
    func bigTitleCloseClick() {
        self.leftNavBackClick()
    }
    
    @objc func leftNavBackClick() {
        if self.navigationController?.viewControllers.count == 1 {
            DoKitHomeWindow.shared.hide()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rightNavTitleClick() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
}

enum DoKitNavBarItemType{
    case text
    case image
}

class DoKitNavBarItemModel {
    var type: DoKitNavBarItemType?
    var text: String?
    var image: UIImage?
    var textColor: UIColor?
    var selector: Selector?
    
    init(title: String?, titleColor: UIColor?, titleSelector: Selector?) {
        type = .text
        text = title
        textColor = titleColor
        selector = titleSelector
    }
    
    init(icon: UIImage?, iconSelector: Selector?) {
        type = .image
        image = icon
        selector = iconSelector
    }
}

 
