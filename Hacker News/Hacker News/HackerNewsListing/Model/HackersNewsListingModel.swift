//
//  HackersNewsListingModel.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import Foundation

class HackersNewsModel : NSObject {
    var newsList : [HackersNewsListingModel]!
    var nbPages : Int?
    init(dictionary : [String : AnyObject]) {
        if let newsListing = dictionary["hits"] as? [AnyObject] {
            self.newsList = []
            for index in newsListing {
                self.newsList.append(HackersNewsListingModel.init(dictionary: index as! [String : AnyObject]))
            }
        }
        
        if let numberOfPages = dictionary["nbPages"] as? Int{
            nbPages = numberOfPages
        }
    }
}


class HackersNewsListingModel: NSObject {
    var created_at : String?
    var title : String?
    var url : String?
    var author : String?
    var points : Int?
    var story_text : String?
    var comment_text : String?
    var num_comments : String?
    var story_id : String?
    var story_title : String?
    var story_url : String?
   
    init(dictionary : [String : AnyObject]) {
        if let createdAt = dictionary["created_at"] as? String{
         self.created_at = createdAt
        }
        if let title = dictionary["title"] as? String{
         self.title = title
        }
        if let url = dictionary["url"] as? String{
        self.url = url
        }
        if let storyText = dictionary["story_text"] as? String{
        self.story_text = storyText
        }
        if let author = dictionary["author"] as? String{
        self.author = author
        }
        if let storyUrl = dictionary["story_url"] as? String{
        self.story_url = storyUrl
        }
    }
}
