//
//  HackerNewsDetailVC.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 11/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import UIKit
import WebKit

class HackerNewsSourceVC: UIViewController,WKNavigationDelegate {
    
    var sourceWebUrl = String()
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL(string:  sourceWebUrl)
        let request = NSURLRequest(url: url! as URL)
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.view.addSubview(webView)
        self.view.sendSubviewToBack(webView)
    }
    
    // MARK: - WKWebView delegate method.
    
    private func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.showLoadingIndicator()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.view.hideLoadingIndicator()
    }
    
}
