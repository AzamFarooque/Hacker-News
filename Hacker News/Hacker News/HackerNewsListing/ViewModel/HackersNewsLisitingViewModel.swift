//
//  HackersNewsLisitingViewModel.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import Foundation

typealias onCompletion = (Bool, String?) -> Void

/// This is NewsListing ViewModel Class which contains all business logic related to NewsListing.
class HackersNewsLisitingViewModel {
    
    // MARK: - HackersNews Model Instance.
    var dataSource : HackersNewsModel!
    // MARK: - HackersNewsListing Model Array.
    var newsListing : [HackersNewsListingModel] = []

    //  Mark : Making Network Request To Fetch News Listing For Related Categories Entered In Searh Bar.
    
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
