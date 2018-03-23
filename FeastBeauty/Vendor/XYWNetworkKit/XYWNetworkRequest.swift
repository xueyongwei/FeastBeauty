//
//  XYWNetworkService.swift
//  jatiin
//
//  Created by 薛永伟 on 2018/3/15.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit
import Alamofire
class XYWNetworkRequest: NSObject {
    
    typealias CompletionHandle = (Any)->()
    typealias FailedHandle = (Error)->()
    
    //这个方法封装了第三方的库
    fileprivate static func asyncRequest(urlStr:String,parameters: Parameters?,headers: HTTPHeaders?,method:HTTPMethod,sucessHandle:@escaping CompletionHandle,failedHandle:@escaping FailedHandle) {
        
        guard let url = URL.init(string: urlStr) else {
            
            debugPrint("URL格式有误！-\(urlStr)")
            
            failedHandle(AFError.invalidURL(url: urlStr))
            
            return
        }
       
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                sucessHandle(json)
//                if let data = json as? Dictionary<String, Any> {
//                    sucessHandle(data)
//                }else{
//                    debugPrint("返回的数据类型有误！-\(urlStr)")
//                    failedHandle(AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.missingContentType(acceptableContentTypes: ["Dictionary"])))
//
//                }
                
            case .failure(let error):
                if let error = error as? AFError {
                    switch error {
                    case .invalidURL(let url):
                        debugPrint("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }
                    
                    print("Underlying error: \(String(describing: error.underlyingError))")
                } else if let error = error as? URLError {
                    print("URLError occurred: \(error)")
                } else {
                    print("Unknown error: \(error)")
                }
                
                //返回错误处理的handle，请求者自处理
                failedHandle(error)
                
            }
        }
    }
    
    
}



//MARK: - 返回对应的请求实例对象
extension XYWNetworkRequest {
    
    static func  getRecommendList(param:Parameters?,completion:@escaping CompletionHandle,failed:@escaping FailedHandle){
        
        var urlStr = XYWAPICenter.getRecomendListUrl()
        
        if let pa = param, let max = pa["max"] as? Int {
            if max > 0 && max < Int.max{
                urlStr.append("&max=\(max)")
            }
            
        }
        
        self.asyncRequest(urlStr: urlStr, parameters: nil, headers: nil, method: .get, sucessHandle: { (result) in
            completion(result)
        }) { (error) in
            
            failed(error)
        }
    }
    
//    static func recommendList() ->XYWNetworkRequest {
//        let request = XYWNetworkRequest.init()
//        request.url = XYWAPICenter.getBaseUrl()
//
//        return request
//    }
//
//    func param(_ param:Dictionary<String,Any>) -> XYWNetworkRequest {
//        self.params = param
//        return self
//    }
    
}

