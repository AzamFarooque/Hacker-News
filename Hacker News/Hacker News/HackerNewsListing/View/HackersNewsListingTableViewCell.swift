//
//  HackersNewsListingTableViewCell.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import UIKit

/// This is HackersNews ListingTableView Cell Class.
class HackersNewsListingTableViewCell: UITableViewCell {
    // MARK: - Title Label.
    @IBOutlet weak var titleTextLabel: UILabel!
    // MARK: - Author Label.
    @IBOutlet weak var authorTextLabel: UILabel!
    // MARK: - Story Text Label.
    @IBOutlet weak var storyTextLabel: UILabel!
    // MARK: - Story Title Label.
    @IBOutlet weak var storyTitleTextLabel: UILabel!
    
    // MARK: - Update TableView Cell Method.
    
    func updateView(section : HackersNewsListingModel){
        if let title = section.title{
            titleTextLabel.text = "Title : \(title)"
        }else{
            titleTextLabel.text = "Title IsEmpty"
        }
        if let storyText = section.story_text{
            storyTextLabel.text = "Story Text : \(storyText)"
        }else{
            storyTextLabel.text = "Story Text IsEmpty"
        }
        if let storyTitle = section.story_title{
            storyTitleTextLabel.text = "Story Title : \(storyTitle)"
        }else{
            storyTitleTextLabel.text = "Story Title IsEmpty"
        }
        if let author = section.author{
            authorTextLabel.text = "Author : \(author)"
        }else{
            authorTextLabel.text = "Author IsEmpty"
        }
    }
}
