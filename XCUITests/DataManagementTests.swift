/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class DataManagementTests: BaseTestCase {

    //Testing the entries are correctly added and deleted. This a termporary behaviour. This test will be changed after releasing Firefox 15.x and Bug 1499074 will be fixed.
    func testWebSiteDataEnterFirstTime() {
        navigator.goto(WebsiteDataSettings)
        XCTAssertEqual(app.tables.cells.count, 2)
        XCTAssertTrue(app.tables.staticTexts["Clear All Website Data"].exists)
        navigator.performAction(Action.AcceptClearAllWebsiteData)
        XCTAssertEqual(app.tables.cells.count, 1)
        navigator.createNewTab()
        navigator.goto(WebsiteDataSettings)
        XCTAssertEqual(app.tables.cells.count, 2)
    }
    
    // Testing the search bar, search results and 'Show More' option.
    func testWebSiteDataOptions() {
        navigator.openURL("google.com")
        navigator.openURL("youtube.com")
        navigator.openURL("twitter.com")
        navigator.openURL("facebook.com")
        navigator.goto(WebsiteDataSettings)
        navigator.performAction(Action.TapOnFilterWebsites)
        app.typeText("google")
        waitforExistence(app.tables["Search results"])
        XCTAssertEqual(app.tables["Search results"].cells.count, 2)
        navigator.performAction(Action.TapOnFilterWebsites)
        XCUIApplication().buttons["Cancel"].tap()
        XCTAssertEqual(app.tables["Search results"].cells.count, 0)
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Show More"]/*[[".cells[\"ShowMoreWebsiteData\"].staticTexts[\"Show More\"]",".staticTexts[\"Show More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertNotEqual(app.tables.cells.count, 9)
    }
}
