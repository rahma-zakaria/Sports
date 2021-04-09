//
//  ActivityIndicator.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/31/21.
//

import Foundation
import UIKit
import ANActivityIndicator

class Indicator{
    var indicator: ANActivityIndicatorView?
    func startAnimating(view: UIView){
        indicator = ANActivityIndicatorView.init(frame: view.frame, animationType: ANActivityIndicatorAnimationType.ballClipRotate, color: .black, padding: CGFloat.init(view.frame.width/3))
        view.addSubview(indicator!)
        indicator!.startAnimating()
    }
    func stopAnimating(){
        indicator!.stopAnimating()
    }
}
