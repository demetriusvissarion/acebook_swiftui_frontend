//
//  SigninTest.swift
//  MobileAcebookUITests
//
//  Created by Ermin Pacia on 22/02/2024.
//

import XCTest

class YourAppUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTapSignInButton() throws {
        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 10))
        signInButton.tap()
   }
    
    func testTypingInTextFields() throws {
    
            let emailTextField = app.textFields["Email"]
            XCTAssertTrue(emailTextField.waitForExistence(timeout: 5))
            emailTextField.tap()
            emailTextField.typeText("test@example.com")
        
            let passwordTextField = app.secureTextFields["Password"]
            XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
            passwordTextField.tap()
            passwordTextField.typeText("testPassword")

            XCTAssertEqual(emailTextField.value as? String, "test@example.com")
            XCTAssertEqual(passwordTextField.value as? String, "••••••••••••")
            // Take a screenshot
            let screenshot = XCUIScreen.main.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            add(attachment)
        }
    
}
