//
//  tembici_challengeUITests.swift
//  tembici-challengeUITests
//
//  Created by Hannah  on 14/05/2020.
//  Copyright © 2020 Hannah . All rights reserved.
//

import XCTest

class tembici_challengeUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    func testShowMovieDetail(){
        let cell = app.tables.cells.firstMatch
        let button = cell.buttons.element.firstMatch
        let titleCell = button.label.components(separatedBy: "\n").first
        
        button.tap()
        
        let titleDetail = app.scrollViews.otherElements.staticTexts["titleDetail"].label
        
        XCTAssertEqual(titleCell, titleDetail, "not show detail movie correct")
        
    }
    
    func testAddAndRemoveFavoriteInMovieDetail() {
        let cell = app.tables.cells.firstMatch
        let button = cell.buttons.element.firstMatch
        button.tap()
        
        let imageName = app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["favorite"]/*[[".buttons[\"star\"]",".buttons[\"favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label
        
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["favorite"]/*[[".buttons[\"star\"]",".buttons[\"favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertNotEqual( app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["favorite"]/*[[".buttons[\"star\"]",".buttons[\"favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label,
                           imageName,
                           "Erro change favorite icon in Movie Details")
                
    }
    
    func testSwipeLeftToRemoveFavorite(){
        
        app.buttons["Favorites"].tap()
        if app.tables.cells.count == 0 {
            app.buttons["Movies"].tap()
            self.loadFavorites()
            app.buttons["Favorites"].tap()
            self.deleteFavorites()
        }else{
            self.deleteFavorites()
        }
        
        XCTAssertEqual(app.tables.cells.count, 0, "Error Remove Favorites")
        
    }
    
    func deleteFavorites(){
        while app.tables.cells.count > 0 {
            let cell = app.tables.cells.firstMatch
            cell.swipeLeft()
            cell.buttons.firstMatch.tap()
        }
    }
    
    func loadFavorites(){
        let tableCells = app.tables.cells
        
        if tableCells.count > 0 && tableCells.count >= 2 {
            let count: Int = 2
            
            for i in stride(from: 0, to: count , by: 1) {
                let tableCell = tableCells.element(boundBy: i)
                for index in stride(from: 0, to: 2 , by: 1) {
                    tableCell.buttons.element(boundBy: index).tap()
                    app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["favorite"]/*[[".buttons[\"star\"]",".buttons[\"favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                    app.navigationBars.buttons["Movs"].tap()
                }
                
                
            }
        }
    }
    
}
