//
//  APIManager.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import Foundation
import Alamofire

typealias ServiceResponse = (AnyObject? , String?) -> Void

class HackerNewsAPIManager{
    static let sharedInstance = HackerNewsAPIManager()
    private init(){}
    let baseUrl = "https://hn.algolia.com/api/v1/search?query="
    
    //  MARK: - API call
    
    func requestAPI(requestMethod : HTTPMethod , inUrl : String?, page : Int , onCompletion: @escaping ServiceResponse) {
        let finalUrl = baseUrl+inUrl!+"?page=\(page)"
        Alamofire.request(finalUrl, method: requestMethod, parameters: nil , headers : nil).validate().responseJSON { (response) in
            var dataSource : AnyObject?
            switch response.result {
            case .success(let JSON):
                dataSource = HackersNewsModel.init(dictionary:(JSON as! [String : AnyObject] as NSDictionary) as! [String : AnyObject])
                DispatchQueue.main.async {
                    onCompletion(dataSource,nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    onCompletion(nil , error as? String)
                }
            }
        }
    }
}

