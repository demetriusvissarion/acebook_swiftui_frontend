//
//  ProfileViewUITest.swift
//  MobileAcebookUITests
//
//  Created by Aisha Mohamed on 21/02/2024.
//

import Foundation
import XCTest


@testable import MobileAcebook
class ProfileViewTests: XCTestCase {
    
    func testNavigationToLoginPage() throws {
        let view = ProfileView()
        let exp = view.body
        
//        let exp = view.inspection.inspect { view in
//            try view.navigationBarTrailing().button(2).tap()
//        }
        
//        XCTAssertNoThrow(try exp.inspect())
//        XCTAssertNotNil(view.$isLoggedOut)
//        XCTAssertTrue(view.isLoggedOut)
    }
    
    // Add similar test cases for other navigation links
    
}
