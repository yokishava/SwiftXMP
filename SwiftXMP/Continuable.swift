//
//  Continuable.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/12/20.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation

protocol Continuable {
    
    associatedtype Element
    
    func removeElements(elements: [Element], start: Int, end: Int) -> [Element]
    
    func insertElements(elements: [Element], start: Int, insertElements: [Element]) -> [Element]
    
    func selectElements(elements: [Element], start: Int, length: Int) -> [Element]
}


struct XMPContinuity: Continuable {
    
    typealias Element = UInt8
    
    func removeElements(elements: [UInt8], start: Int, end: Int) -> [UInt8] {
        var counter = start
        var _elements = elements
        while counter < end {
            _elements.remove(at: start)
            counter = counter + 1
        }
        return _elements
    }
    
    func insertElements(elements: [UInt8], start: Int, insertElements: [UInt8]) -> [UInt8] {
        var index = start
        var _elements = elements
        
        insertElements.forEach({
            _elements.insert($0, at: index)
            index = index + 1
        })
        return _elements
    }
    
    func selectElements(elements: [UInt8], start: Int, length: Int) -> [UInt8] {
        var _elements: [Element] = []
        for index in start..<start + length {
            _elements.append(elements[index])
        }
        return elements
    }
}

extension XMPContinuity {
    
    typealias ReturnType = String
    
    func getSpecifiedRangeStringFromBytes(bytes: [Element], start: Int, length: Int) -> String {
        let _bytes = selectElements(elements: bytes, start: start, length: length)
        let data = Data(bytes: _bytes)
        guard let str = String(data: data, encoding: .utf8) else { return "" }
        return str
    }
    
}
