//
//  Exif.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/10/01.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation
import MobileCoreServices
import ImageIO

class Exif {
    
    static func exif(path: String) {
        let url = URL(fileURLWithPath: path)
        let cgImg = CGImageSourceCreateWithURL(url as CFURL, nil)
        
        let exif = NSMutableDictionary()
        exif.setObject("add user comment to jpg file!", forKey: kCGImagePropertyExifUserComment as! NSCopying)
        
        let metaData = NSMutableDictionary()
        metaData.setObject(exif, forKey: kCGImagePropertyExifDictionary as! NSCopying)
        
        let dest: CGImageDestination? = CGImageDestinationCreateWithURL(url as CFURL, kUTTypeJPEG, 1, nil)
        CGImageDestinationAddImageFromSource(dest!, cgImg!, 0, metaData)
        CGImageDestinationFinalize(dest!)
    }
    
//    static func exif(data: Data) {
//        let cgImg = CGImageSourceCreateWithData(data as CFData, nil)
//
//        let exif = NSMutableDictionary()
//        exif.setObject("add user comment to jpg file!", forKey: kCGImagePropertyExifUserComment as! NSCopying)
//
//        let metaData = NSMutableDictionary()
//        metaData.setObject(exif, forKey: kCGImagePropertyExifDictionary as! NSCopying)
//
//        let imgData = NSMutableData()
//
//        let dest: CGImageDestination? = CGImageDestinationCreateWithData(imgData, kUTTypeJPEG, 1, nil)
//        CGImageDestinationAddImage(dest!, cgImg!, metaData)
//        CGImageDestinationFinalize(dest!)
//    }
    
}
