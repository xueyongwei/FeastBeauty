//
//  RecommentTableViewCell.swift
//  FeastBeauty
//
//  Created by 薛永伟 on 2018/3/22.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class RecommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addDoubleTapRecognizer()
        
        // Initialization code
    }
    
    func addDoubleTapRecognizer() {
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapImageView(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    @objc func doubleTapImageView(_ sender: UITapGestureRecognizer) {
        debugPrint("DoubleTapImageView")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
