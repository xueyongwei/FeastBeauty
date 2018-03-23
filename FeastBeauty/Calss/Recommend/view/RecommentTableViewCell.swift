//
//  RecommentTableViewCell.swift
//  FeastBeauty
//
//  Created by 薛永伟 on 2018/3/22.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
import Kingfisher
class RecommentTableViewCell: UITableViewCell {

    var pin:Pin!{
        didSet{
            self.imgView.kf.setImage(with: URL.init(string: pin.imageUrl()), placeholder: UIImage(), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        self.customScrollview()
        
        // Initialization code
    }
    func customScrollview(){
//        self.contentScrollView.delegate = self
//        self.contentScrollView.minimumZoomScale = 1.0
//        self.contentScrollView.maximumZoomScale = 1.1
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RecommentTableViewCell:UIScrollViewDelegate {
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return self.imgView
//    }
//
//    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        if scale != 1.0 {
//            scrollView.setZoomScale(1.0, animated: true)
//        }
//    }
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        if scrollView.zoomScale >= 1.5 {
//
//        }
//    }
}
