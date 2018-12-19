//
//  Result.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/09/30.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

public enum Result<T> {
    
    case success(T)
    
    case failed(Error)
    
}
