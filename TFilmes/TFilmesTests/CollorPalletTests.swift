//
//  TFilmesTests.swift
//  TFilmesTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 06/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import TFilmes

class CollorPalletTests: XCTestCase {

    func testAllCollorsIsSeted() throws {
        XCTAssertNoThrow(CollorPallet.primary)
        XCTAssertNoThrow(CollorPallet.secondary)
        XCTAssertNoThrow(CollorPallet.tertiary)
        XCTAssertNoThrow(CollorPallet.white)
        XCTAssertNoThrow(CollorPallet.background)
        XCTAssertNoThrow(CollorPallet.gray)
    }

}
