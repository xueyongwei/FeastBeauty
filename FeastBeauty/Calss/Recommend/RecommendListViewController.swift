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
    
    var dataSource = [Any].init()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customTableView()
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
        return 30
//        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommentTableViewCell", for: indexPath)
        return cell
    }
}
