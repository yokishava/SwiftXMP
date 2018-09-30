//
//  SwiftXMPTests.swift
//  SwiftXMPTests
//
//  Created by 吉川昂広 on 2018/09/29.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import XCTest
@testable import SwiftXMP

class SwiftXMPTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testRemoveBytes() {
        let collection: [UInt8] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection: [UInt8] = [0, 1, 2, 3, 8, 9, 10]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.removeBytes(bytes: collection, start: 4, end: 8)
        
        XCTAssertEqual(result, _collection)
    }
    
    func testRemoveBytes_generics() {
        let collection = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection = [0, 1, 2, 3, 8, 9, 10]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.removeBytes(bytes: collection, start: 4, end: 8)
        
        XCTAssertEqual(result, _collection)
    }
    
    func testInsertBytes() {
        let collection: [UInt8] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection: [UInt8] = [0, 1, 2, 3, 21, 22, 23, 24, 25, 4, 5, 6, 7, 8, 9, 10]
        let insertCollection: [UInt8] = [21, 22, 23, 24, 25]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.insertBytes(bytes: collection, start: 4, insertBytes: insertCollection)
        
        XCTAssertEqual(result, _collection)
    }

    func testInsertBytes_generics() {
        let collection = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection = [0, 1, 2, 3, 21, 22, 23, 24, 25, 4, 5, 6, 7, 8, 9, 10]
        let insertCollection = [21, 22, 23, 24, 25]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.insertBytes(bytes: collection, start: 4, insertBytes: insertCollection)
        
        XCTAssertEqual(result, _collection)
    }
    
    func testSelectBytes() {
        let collection: [UInt8] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection: [UInt8] = [1, 2, 3, 4]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.selectBytes(bytes: collection, start: 1, length: 4)
        
        XCTAssertEqual(result, _collection)
    }
    
    func testSelectBytes_generics() {
        let collection = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let _collection = [1, 2, 3, 4]
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.selectBytes(bytes: collection, start: 1, length: 4)
        
        XCTAssertEqual(result, _collection)
    }
    
    func testGetBytesString() {
        let str = "http://ns.adobe.com/xap/1.0/"
        
        let data = str.data(using: .utf8)!
        
        let bytes = data.map({$0})
        
        let swiftXmp = SwiftXMP()
        let result = swiftXmp.getBytesString(bytes: bytes, start: 0, length: bytes.count)
        
        XCTAssertEqual(str, result)
    }
    
//    func testFindExifIndex() {
//        let image = UIImage(named: "dest.jpg")!
//        let imgData = UIImageJPEGRepresentation(image, 1.0)!
//        let swiftXmp = SwiftXMP()
//        let bytes = swiftXmp.convertDataToBytes(data: imgData)
//        let result = swiftXmp.findXmp(bytes: bytes)
//        XCTAssertNotNil(result.exifHead)
//        XCTAssertNil(result.head)
//        XCTAssertNil(result.end)
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
