//
//  XYWAPI.swift
//  FeastBeauty
//
//  Created by 薛永伟 on 2018/3/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
import Alamofire

class XYWAPI: NSObject {

    class Urls {
        //MARK: - FeastBeauty的接口
        static func recomendListUrl() -> String {
            return "http://api.huaban.com/boards/28187419/pins/?limit=20"
        }
    }
    
    class Request {
        
        var url:String
        var parameters:Parameters?
        var headers:HTTPHeaders?
        var method:HTTPMethod = .get
        
        init(url:String) {
            self.url = url
        }
        
        typealias CompletionHandle = (Dictionary<String,Any>)->()
        typealias FailedHandle = (Error)->()
        
        //这个方法封装了第三方的库
        func asyncRequest(complete:@escaping CompletionHandle,failed:@escaping FailedHandle) {
            
            guard let aurl = URL.init(string: url) else {
                
                debugPrint("URL格式有误！-\(url)")
                
                failed(AFError.invalidURL(url: url))
                
                return
            }
            
            Alamofire.request(aurl, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { [weak self] (response) in
                guard let strongSelf = self else {
                    return
                }
                switch response.result {
                case .success(let json):
                    if let data = json as? Dictionary<String, Any> {
                        complete(data)
                    }else{
                        debugPrint("返回的数据类型有误！-\(strongSelf.url)")
                        failed(AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.missingContentType(acceptableContentTypes: ["Dictionary"])))
                        
                    }
                    
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
                    failed(error)
                    
                }
            }
        }
        
        
        
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
                    if let data = json as? Dictionary<String, Any> {
                        sucessHandle(data)
                    }else{
                        debugPrint("返回的数据类型有误！-\(urlStr)")
                        failedHandle(AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.missingContentType(acceptableContentTypes: ["Dictionary"])))
                        
                    }
                    
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
}

class FeastBeaytyRequest: XYWAPI.Request {
    var currentMax = 0
    
    static func recommentList() ->FeastBeaytyRequest{
        let request = FeastBeaytyRequest.init(url: XYWAPI.Urls.recomendListUrl())
        request.currentMax = 0
        return request
    }
    
}
extension XYWAPI.Request {
    
    
    func reommendList() -> XYWAPI.Request {
        let req = XYWAPI.Request.init(url: "")
        
        return req
    }
}
