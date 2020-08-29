import XCTest

class superPotsUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app.launch()
    }

    func testAuth() {
        app.textFields.element(boundBy: 0).firstMatch.tap()
        app.textFields.element(boundBy: 0).typeText("Nikolay@gmail.ru")
        app.buttons["next"].tap()
        app.secureTextFields.element(boundBy: 0).typeText("test")
        app.buttons["done"].tap()
        app.buttons["Войти"].tap()
        sleep(20)
    }
}
