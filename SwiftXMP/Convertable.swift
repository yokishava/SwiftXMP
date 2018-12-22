//
//  Convertable.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/12/22.
//  Copyright © 2018 takahiro yoshikawa. All rights reserved.
//

import Foundation

protocol Convertible {
    associatedtype T
    associatedtype U
    associatedtype V
}

struct XmpConverter: Convertible {
    
    typealias T = String
    
    typealias U = [UInt8]
    
    typealias V = Data
    
    fileprivate func map(_ data: V) -> U {
        return data.map({$0})
    }
    
    //Data => [UInt8]
    func convertDataToBytes(_ data: V) -> U {
        return map(data)
    }
    
    //String => [UInt8]
    func convertStringToBytes(_ str: T) -> U {
        let data = str.data(using: .utf8)!
        return map(data)
    }
    
}
