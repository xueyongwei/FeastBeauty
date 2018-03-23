//
//  Board.swift
//  FeastBeauty
//
//  Created by 薛永伟 on 2018/3/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit


struct Pin:Mappable {
    
    var pin_id:Int
    var file:File
    
    struct File:Mappable {
//        var width:Float = 0.0
//        var height:Int
        var type:String
        var key:String
        var bucket:String

//        enum CodingKeys : String, CodingKey {
//            case width
//            case height
//            case type
//            case key
//            case bucket
//        }

    }
    
    enum CodingKeys : String, CodingKey {
        case pin_id
        case file
    }
    enum imageSizeType:String {
        case low = "_fw192"
        case normal = "_fw320"
        case original = ""
    }
    
    func imageUrl(sizeType:imageSizeType = .original ) -> String {
        let urlstr = self.imageBaseUrl() + self.file.key + sizeType.rawValue
        debugPrint(urlstr)
        return urlstr
    }
    
    fileprivate func imageBaseUrl() -> String{
        
        let bucket = self.file.bucket
        
        switch bucket {
        case "hb-topic-img":
            return "http://hb-topic-img.b0.upaiyun.com/"
        case "hbfile":
            return "http://hbfile.b0.upaiyun.com/"
        default:
            return "http://img.hb.aicdn.com/"
        }
    }
 
}


