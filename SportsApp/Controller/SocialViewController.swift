//
//  SocialViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/28/21.
//

import UIKit
import WebKit

class SocialViewController: UIViewController {

    @IBOutlet weak var socialWebView: WKWebView!
    var socialLink:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if socialLink.isEmpty {
            let image = UIImage(named: "notFound")
            let imageView = UIImageView(image: image!)
            imageView.frame = view.frame
            view.addSubview(imageView)
        }
        let myURL = URL(string: "https://\(socialLink)")
        let myRequest = URLRequest(url: myURL!)
        socialWebView.load(myRequest)
    }

}
