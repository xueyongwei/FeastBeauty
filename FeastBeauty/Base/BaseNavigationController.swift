//
//  BaseNavigationController.swift
//  Browser
//
//  Created by 115 on 2017/9/5.
//  Copyright © 2017年 114la.com. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var fullScreenGe: UIPanGestureRecognizer!
    
    var canDragBack = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customFullScreenBackGe()
        
//        self.setClearNavigation()
        
    }
    
    //push的时候根据情况添加默认的返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 0 {
            viewController.navigationItem.leftBarButtonItem = createNavBackButton()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    let backImage = UIImage(named: "nav_bar_return")!.withRenderingMode(.alwaysOriginal)
    
    func createNavBackButton() -> UIBarButtonItem {
        return UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(myPopVC))
    }
    
   
    
    @objc func myPopVC() {
        self.popViewController(animated: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    func customFullScreenBackGe() {
        let target = self.interactivePopGestureRecognizer?.delegate
        
        let sel = NSSelectorFromString("handleNavigationTransition:")
        
        let targetView = self.interactivePopGestureRecognizer?.view
        
        fullScreenGe = UIPanGestureRecognizer(target: target, action: sel)
        
        fullScreenGe.delegate = self
        
        targetView?.addGestureRecognizer(fullScreenGe)
        
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard verifySpecialVCPassed() else{
            return false
        }
        
        guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        if translation.x <= 0 { return false }
        return self.childViewControllers.count == 1 ? false : true
    }

    /// 验证特殊的控制器是否允许全屏的返回手势
    ///
    /// - Returns: 返回true则表示可以全屏返回
    func verifySpecialVCPassed() -> Bool{
        /*
         if let myFavsViewController = self.childViewControllers.last as? MyFavsViewController {
         if myFavsViewController.scrollView.contentOffset.x > 0 {
         return false
         }
         }
 */
        return true
    }
}

extension BaseNavigationController {
    func setClearNavigation() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
}
