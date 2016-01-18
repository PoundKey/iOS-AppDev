//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Chang Tong Xue on 2016-01-16.
//  Copyright © 2016 DX. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    var controller = CalViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCalculate() {
        var res = controller.calculate("10", input: "30", op: "x")
        XCTAssertEqual(res, "300")
        
        res = controller.calculate("10", input: "30", op: "+")
        XCTAssertEqual(res, "40")
        
        res = controller.calculate("10", input: "30", op: "-")
        XCTAssertEqual(res, "-20")
        
        res = controller.calculate("30", input: "10", op: "÷")
        XCTAssertEqual(res, "3")
        
        res = controller.calculate("2", input: "10", op: "÷")
        XCTAssertEqual(res, "0.2")
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
