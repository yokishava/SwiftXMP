//
//  SwiftXMP.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/09/29.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

open class SwiftXMP {
    
    public init() {}
    
    //jpgなどのファイルパス
    open func embedXmp(contens: URL, xml: String) -> Result<Data> {
        do {
            let data = try Data(contentsOf: contens)
            let bytes = convertDataToBytes(data: data)
            let indexes = findXmp(bytes: bytes)
            let newData = writeXmp(bytes: bytes, xmpHeadIndex: indexes.head, xmpEndIndex: indexes.end, exifHeadIndex: indexes.exifHead, xml: xml)
            return .success(newData)
        } catch let e {
            print("error : \(e.localizedDescription)")
            return .failed(e)
        }
    }
    
    //jpgなどのデータ
    open func embedXmp(contens: Data, xml: String) -> Data {
        let bytes = convertDataToBytes(data: contens)
        let indexes = findXmp(bytes: bytes)
        let newData = writeXmp(bytes: bytes, xmpHeadIndex: indexes.head, xmpEndIndex: indexes.end, exifHeadIndex: indexes.exifHead, xml: xml)
        return newData
    }
    
    internal func findXmp(bytes: [UInt8]) -> (head: Int?, end: Int?, exifHead: Int?) {
        //XMPの始まりのindex(0xFFE1のFFにあたる部分)
        var xmpHeadIndex: Int?
        //XMPの終わりのindex
        //XMPのセグメントの次のセグメント(0xFF~)の1つ前のindex
        var xmpEndIndex: Int?
        //Exifの始まりのindex
        var exifHeadIndex: Int?
        
        //xmpのindexを検索
        for (index, value) in bytes.enumerated() {
            if value == 0xFF {
                //APP1 segment : 0xFFE1
                if bytes[index + 1] == 0xE1 {
                    let start = index + 4
                    let bytesStr = getBytesString(bytes: bytes, start: start, length: 28)
                    if bytesStr == "http://ns.adobe.com/xap/1.0/" {
                        xmpHeadIndex = index
                        xmpEndIndex = findEndXmpIndex(start: start, bytes: bytes)
                    } else {
                        exifHeadIndex = index
                    }
                }
            }
        }
        return (xmpHeadIndex, xmpEndIndex, exifHeadIndex)
    }
    
    internal func writeXmp(bytes: [UInt8], xmpHeadIndex: Int?, xmpEndIndex: Int?, exifHeadIndex: Int?, xml: String) -> Data {
        //xmlから新しいxmpをセグメント単位で作成
        let xmp = createXmp(xml: xml)
        
        if let headIndex = xmpHeadIndex, let endIndex = xmpEndIndex {
            //XMPがある場合
            print("head index : \(headIndex)")
            print("end index : \(endIndex)")
        
            //元々存在するXMPをセグメント単位で削除
            let removedBytes = removeBytes(bytes: bytes, start: headIndex, end: endIndex)
            //新しいxmpを埋め込む（Exifのセグメントの後）
            let insertedBytes = insertBytes(bytes: removedBytes, start: headIndex, insertBytes: xmp)
            return Data(bytes: insertedBytes)
        } else {
            //XMPがない場合
            //元のbytesにxmpを埋め込む（Exif 0xFFE1の手前）
            let insertedBytes = insertBytes(bytes: bytes, start: exifHeadIndex!, insertBytes: xmp)
            return Data(bytes: insertedBytes)
        }
    }
    
    //Data -> [UInt8]
    internal func convertDataToBytes(data: Data) -> [UInt8] {
        return data.map({$0})
    }
    
    //xmpを新しく作成
    //create new XMP
    internal func createXmp(xml: String) -> [UInt8] {
        let adobe = "http://ns.adobe.com/xap/1.0/"
        let header = "<?xpacket begin=\"\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?>"
        let footer = "<?xpacket end=\"w\"?>"
        
        /*
            string => [UInt8]
        */
        //convert "http://ns.adobe.com/xap/1.0/" to [UInt8]
        var adobeBytes = convertStringToBytes(value: adobe)
        //convert "<?xpacket begin=\"\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?>" to [UInt8]
        let headerBytes = convertStringToBytes(value: header)
        //convert "<?xpacket end=\"w\"?>" to [UInt8]
        let footerBytes = convertStringToBytes(value: footer)
        //xml 開発者、ユーザーが実際に加えたいXMLの文字列
        //convert xml to [UInt8]
        var xmlBytes = convertStringToBytes(value: xml)
        
        // "http://ns.adobe.com/xap/1.0/"の直前に1byteの空白が存在するため
        //1byte分の空白（16進数では0x00）を追加する
        adobeBytes.append(0x00)
        
        //XMPの仕様に基づいて、変換した[UInt8]を結合する
        // "http://ns.adobe.com/xap/1.0/"
        // <?xpacket begin=\"\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?>
        //   xml
        // "<?xpacket end=\"w\"?>"
        xmlBytes = adobeBytes + headerBytes + xmlBytes + footerBytes
        
        print("xmlBytes count : \(xmlBytes.count)")
        print("Hexadecimal : \(String(xmlBytes.count, radix: 16))")
        
        //+2 はセグメントのデータ長と内容とで、できるバイト数へ数を合わせるため
        //セグメントのデータ長を表わす分のbyte分(2bytes)を[UInt8]型のxmlBytesに追加する
        var count = xmlBytes.count + 2
        
        let data = Data(bytes: &count, count: MemoryLayout.size(ofValue: count))
        
        let bytes = data.map({$0})
        
        //bytes.count : データ長　0xFFFE1 の次の2byteに入れるデータ長の数
        print("create xmp bytes count : \(bytes.count)")
        
        //big endian, little endian の関係でbytes[1]から入れている
        var xmpBytes = [0xFF, 0xE1, bytes[1], bytes[0]]
        xmpBytes = xmpBytes + xmlBytes
        return xmpBytes
    }
    
    //String → [UInt8]
    internal func convertStringToBytes(value: String) -> [UInt8] {
        let data = value.data(using: .utf8)!
        return data.map({$0})
    }
    
    //指定した範囲のbytes（[UInt8]）を削除
    internal func removeBytes<Element>(bytes: [Element], start: Int, end: Int) -> [Element] {
        let index = start
        var counter = start
        var _bytes = bytes
        while (counter < end) {
            _bytes.remove(at: index)
            counter = counter + 1
        }
        return _bytes
    }
    
    //指定した位置にbytes（[UInt8]）を挿入
    internal func insertBytes<Element>(bytes: [Element], start: Int, insertBytes: [Element]) -> [Element] {
        var index = start
        var _bytes = bytes
        insertBytes.forEach({
            _bytes.insert($0, at: index)
            index = index + 1
        })
        return _bytes
    }
    
    //XMPのセグメントの最後にあたるindexを取得
    internal func findEndXmpIndex(start: Int, bytes: [UInt8]) -> Int {
        //29 : "http://ns.adobe.com/xap/1.0/"の次のbyteのindexを示す
        var offset = start + 29
        var xmpEndIndex = 0
        while (offset < bytes.count) {
            if getBytesString(bytes: bytes, start: offset, length: 19) == "<?xpacket end=\"w\"?>" {
                //Xmpの最後のindex
                //19 : "<?xpacket end=\"w\"?>" のbyte分
                xmpEndIndex = offset + 19
                break
            } else {
                offset = offset + 1
            }
        }
        return xmpEndIndex
    }
    
    //指定した範囲のbytes([UInt8])を取得
    internal func selectBytes<Element>(bytes: [Element], start: Int, length: Int) -> [Element] {
        var _bytes: [Element] = []
        for index in start..<start + length {
            _bytes.append(bytes[index])
        }
        return _bytes
    }
    
    //指定範囲のbytes → String
    internal func getBytesString(bytes: [UInt8], start: Int, length: Int) -> String {
        let _bytes = selectBytes(bytes: bytes, start: start, length: length)
        let data = Data(bytes: _bytes)
        if let str = String(data: data, encoding: .utf8) {
            return str
        } else {
            return ""
        }
    }
}

