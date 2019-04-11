//
//  HackersNewsLisitingViewModel.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import Foundation

typealias onCompletion = (Bool, String?) -> Void

class HackersNewsLisitingViewModel {
    
    var dataSource : HackersNewsModel!
    var newsListing : [HackersNewsListingModel] = []

    //  Mark : GetFlickerListing Detail and UpdateModel
    
    func getNewsListing(inUrl : String , page : Int , completionBlock : @escaping onCompletion){
        HackerNewsAPIManager.sharedInstance.requestAPI(requestMethod : .get, inUrl: inUrl ,page : page) { (data, error) in
            if error == nil {
                if let uploadID = data  {
                    self.dataSource = uploadID as? HackersNewsModel
                    self.newsListing += self.dataSource.newsList
                    completionBlock(true , nil)
                }
            } else {
                completionBlock(true , error)
            }
        }
    }
}
