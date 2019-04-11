//
//  ViewController.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import UIKit

/// This is News Listing Class.
class HackerNewsListingVC: UIViewController {
    // MARK: - TableView Instance Intialise.
    @IBOutlet weak var newsListingTableView: UITableView!
    // MARK: - HackersNewsLisitingViewModel Instance Intialise.
    let viewModel : HackersNewsLisitingViewModel = HackersNewsLisitingViewModel()
    // MARK: - Current Page Number Instance Intilaise and Assigned Value.
    var currentPage : Int?
    // MARK: - Categories To Search
    var serachCategories : String?
    // MARK: - ReuseIdentifier
    let reuseIdentifier = "HackersNewsListingTableViewCell"
    
    //MARK: - ViewDidLoad Method.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsListingTableView.tableFooterView = UIView()
    }
    
    // MARKS: - Fetch Hacker News
    
    /*
     
     This method is use to fetch news listing from server.
     ### Querry Parameters ###
     1. newsCategories : Text Enterd In Search Bar.
     2. page : Page Number.
     
     
     */
    
    func hackersNewsFetching(newsCategories : String , page : Int){
        viewModel.getNewsListing(inUrl : newsCategories , page : page) { (success, error) in
            if success {
                self.view.hideLoadingIndicator()
                self.reloadTableView()
            } else if error != nil {
                print(error!)
            }
        }
    }
    
    // MARK: - Reload TableView
    
    func reloadTableView(){
        newsListingTableView.delegate = self
        newsListingTableView.dataSource = self
        newsListingTableView.reloadData()
    }
}

extension HackerNewsListingVC : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - TableView Delegates And DataSource.
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsListing.count == 0 ? 0 : viewModel.newsListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! HackersNewsListingTableViewCell
        cell.updateView(section : viewModel.newsListing[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.newsListing.count-1 && viewModel.dataSource.nbPages! >= currentPage!{
            currentPage = currentPage! + 1
            self.setTableFooter()
            hackersNewsFetching(newsCategories: serachCategories! , page : currentPage!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let soureUrl = viewModel.newsListing[indexPath.row].story_url else {alertIfSourceUrlEmpty()
            return}
        let storyboard = UIStoryboard(storyboard: .NewsSource)
        let sourceVC : HackerNewsSourceVC = storyboard.instantiateViewController()
        sourceVC.sourceWebUrl = soureUrl
        self.navigationController?.pushViewController(sourceVC, animated: true)
    }
    
    // MARK: - Alert User If Source Url Is Empty.
    
    func alertIfSourceUrlEmpty(){
        let alertController: UIAlertController = UIAlertController(title: HackerNewsConstant.AppName, message: HackerNewsConstant.sourceUrlEmptyMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - To Show ActivityIndicator In TableView Footer While Pagination.
    
    func setTableFooter()  {
        let pagingSpinner = UIActivityIndicatorView(style: .gray)
        pagingSpinner.startAnimating()
        pagingSpinner.color = UIColor.blue
        pagingSpinner.hidesWhenStopped = true
        newsListingTableView.tableFooterView = pagingSpinner
    }
}

extension HackerNewsListingVC : UISearchBarDelegate{
    
    // MARK: - Search Bar Delegate Method.
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentPage = 0
        serachCategories = searchBar.text
        self.viewModel.newsListing.removeAll()
        self.view.showLoadingIndicator()
        hackersNewsFetching(newsCategories: searchBar.text! , page : 0)
        searchBar.resignFirstResponder()
        newsListingTableView.reloadData()
    }
}


