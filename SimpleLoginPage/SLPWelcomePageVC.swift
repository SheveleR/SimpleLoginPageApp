//
//  SLPWelcomePageVC.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import UIKit

class SLPWelcomePageVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

