//
//  RecommendListViewController.swift
//  FeastBeauty
//
//  Created by 薛永伟 on 2018/3/22.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class RecommendListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Pin].init()
    
    ///当前请求到的那个pin
    var currentMax = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func addDoubleTapRecognizer() {
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapImageView(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    @objc func doubleTapImageView(_ sender: UITapGestureRecognizer) {
        debugPrint("DoubleTapImageView")
        YPDouYinLikeAnimation.shareInstance().createAnimation(withTap: sender)
//        [[YPDouYinLikeAnimation shareInstance] createAnimationWithTouch:touches withEvent:event];
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customTableView()
        
        self.addDoubleTapRecognizer()
        
        XYWNetworkRequest.getRecommendList(param: ["max":currentMax], completion: { (result) in
            print(result)
            let res = result as! Dictionary<String,Any>
            let pins = res["pins"] as! Array<Dictionary<String,Any>>
            
            
            for pin in pins {
//                guard let pin_id = pin["pin_id"] as? Int,let file = pin["file"] as? Dictionary<String,Any> else{
//                    return
//                }
//                print(pin_id)
//                print(file)
//
//                if let width = file["width"] as? Int {
//                    print(width)
//                }
                
                
                if let pinModel = try? Pin.mapFromDict(pin, Pin.self){
                    print(pinModel)
                    self.dataSource.append(pinModel)

                }
                
            }
            self.tableView.reloadData()

            
//            let pins = resule["pins"] as? Array
//            for pin in pins {
//
//            }
            
        }) { (error) in
            print(error)
        }
        // Do any additional setup after loading the view.
    }

    func customTableView()  {
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.tableView.register(UINib.init(nibName: "RecommentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecommentTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.view.bounds.size.height
        self.tableView.isPagingEnabled = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
                                          
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension RecommendListViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 30
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommentTableViewCell", for: indexPath) as! RecommentTableViewCell
        cell.pin = self.dataSource[indexPath.row]
        return cell
    }
}
