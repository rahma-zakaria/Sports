//
//  YoutubeViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/27/21.
//

import UIKit
import WebKit

class YoutubeViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var youtubeWebView: WKWebView!
    var youtubeLink:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://\(youtubeLink)")
        
        let myRequest = URLRequest(url: myURL!)
        youtubeWebView.load(myRequest)
        
    }
    
}
