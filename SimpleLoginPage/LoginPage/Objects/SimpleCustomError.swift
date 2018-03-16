//
//  SimpleCustomError.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 16/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

class SimpleCustomError: Error {
    var errorMsg: String!
    init(withErrorLocalizedString: String) {
        self.errorMsg = withErrorLocalizedString
    }
}
