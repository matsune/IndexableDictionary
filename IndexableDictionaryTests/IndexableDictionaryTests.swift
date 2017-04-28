//
//  IndexableDictionaryTests.swift
//  IndexableDictionaryTests
//
//  Created by Yuma Matsune on 2017/04/26.
//  Copyright © 2017年 matsune. All rights reserved.
//

import XCTest
@testable import IndexableDictionary

class IndexableDictionaryTests: XCTestCase {
    
    var idxDictionary = IndexableDictionary<String, Int>()
    
    override func setUp() {
        super.setUp()
        idxDictionary = [("a", 1), ("b", 2), ("c", 3)]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSubscriptPosition() {
        XCTAssertEqual(idxDictionary[0].key, "a")
        XCTAssertEqual(idxDictionary[1].key, "b")
        XCTAssertEqual(idxDictionary[2].key, "c")
    }
    
    func testSubscriptBounds() {
        XCTAssertEqual(idxDictionary[0..<3].map {$0.key}, ["a", "b", "c"])
    }
    
    func testSubscriptKey() {
        XCTAssertEqual(idxDictionary["a"], 1)
        XCTAssertEqual(idxDictionary["b"], 2)
        XCTAssertEqual(idxDictionary["c"], 3)
    }
    
    func testIndexForKey() {
        XCTAssertEqual(idxDictionary.index(forKey: "a"), 0)
        XCTAssertEqual(idxDictionary.index(forKey: "b"), 1)
        XCTAssertEqual(idxDictionary.index(forKey: "c"), 2)
    }
    
    func testKeys() {
        XCTAssertEqual(idxDictionary.keys.map {$0}, ["a", "b", "c"])
    }
    
    func testValues() {
        XCTAssertEqual(idxDictionary.values.map {$0}, [1, 2, 3])
    }
    
    func testRemoveValueForKey() {
        XCTAssertEqual(idxDictionary.removeValue(forKey: "a"), 1)
        XCTAssertEqual(idxDictionary.removeValue(forKey: "a"), nil)
    }
    
    func testUpdateValue() {
        XCTAssertEqual(idxDictionary.updateValue(100, forKey: "a"), 1)
        XCTAssertEqual(idxDictionary.updateValue(100, forKey: "z"), nil)
    }
}
