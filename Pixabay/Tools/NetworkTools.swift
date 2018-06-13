//
//  NetworkTools.swift
//  Pixabay
//
//  Created by PlutusCat on 2018/6/11.
//  Copyright © 2018年 Pixabay. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkTools: NSObject {


    /// 网络请求
    ///
    /// - Parameters:
    ///   - URLString: 请求地址
    ///   - method: 请求方式 [.get .post]
    ///   - paramet: 请求参数
    ///   - finishedCallback: 返回成功
    ///   - errorback: 返回失败
    class func request(URLString : String,
                       method: HTTPMethod = .get,
                       paramet : Parameters? = nil,
                       finishedCallback :  @escaping (_ result : Any) -> (),
                       errorback : @escaping (_ result : Any) -> ()) {

        Alamofire.request(URLString, method: method, parameters: paramet, encoding: JSONEncoding.default).responseJSON { (response) in

            guard let result = response.result.value else {
                errorback(response.result.error!)
                return
            }

            finishedCallback(result)
        }
    }

}
