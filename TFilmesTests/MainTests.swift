//
//  MainTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes

class MainTests: XCTestCase {

    var mainViewController = MainViewController()

    private var totalOfItems: Int {
        self.mainViewController.collectionView.numberOfItems(inSection: 0)
    }

    override func setUpWithError() throws {
        super.setUp()
        //1
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.mainViewController = storyboard.instantiateInitialViewController() as! MainViewController
        XCTAssertNotNil(mainViewController.view)
        sleep(1) //Complete request
    }

    override func tearDownWithError() throws {

    }

    func testGetDataFromAPI() throws {
        XCTAssertGreaterThan(self.totalOfItems, 0)
    }

}

