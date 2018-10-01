//
//  Xmp.swift
//  Demo
//
//  Created by 吉川昂広 on 2018/10/01.
//  Copyright © 2018年 takahiro yoshikawa. All rights reserved.
//

import Foundation

class Xmp {
    
    static func xmp() -> String {
        
        let xmp = "<x:xmpmeta xmlns:x=\"adobe:ns:meta/\">"
                    + "<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#'>"
                        + "<rdf:Description rdf:about='Test:kSimpleRDF/' xmlns:ns1='ns:test1/' xmlns:ns2='ns:test2/'>"
                            + "<ns1:SimpleProp>Simple value</ns1:SimpleProp>"
                            + "<ns1:ArrayProp>"
                                + "<rdf:Bag>"
                                    + "<rdf:li>Item1 value</rdf:li>"
                                    + "<rdf:li>Item2 value</rdf:li>"
                                + "</rdf:Bag>"
                            + "</ns1:ArrayProp>"
                            + "<ns1:StructProp rdf:parseType='Resource'>"
                                + "<ns2:Field1>Field1 value</ns2:Field1>"
                                + "<ns2:Field2>Field2 value</ns2:Field2>"
                            + "</ns1:StructProp>"
                            + "<ns1:QualProp rdf:parseType='Resource'>"
                                + "<rdf:value>Prop value</rdf:value>"
                                + "<ns2:Qual>Qual value</ns2:Qual>"
                            + "</ns1:QualProp>"
                            + "<ns1:AltTextProp>"
                                + "<rdf:Alt>"
                                    + "<rdf:li xml:lang='x-one'>x-one value</rdf:li>"
                                    + "<rdf:li xml:lang='x-two'>x-two value</rdf:li>"
                                + "</rdf:Alt>"
                            + "</ns1:AltTextProp>"
                            + "<ns1:ArrayOfStructProp>"
                                + "<rdf:Bag>"
                                    + "<rdf:li rdf:parseType='Resource'>"
                                        + "<ns2:Field1>Item-1</ns2:Field1>"
                                        + "<ns2:Field2>Field 1.2 value</ns2:Field2>"
                                    + "</rdf:li>"
                                    + "<rdf:li rdf:parseType='Resource'>"
                                        + "<ns2:Field1>Item-2</ns2:Field1>"
                                        + "<ns2:Field2>Field 2.2 value</ns2:Field2>"
                                    + "</rdf:li>"
                                + "</rdf:Bag>"
                            + "</ns1:ArrayOfStructProp>"
                        + "</rdf:Description>"
                    + "</rdf:RDF>"
                + "</x:xmpmeta>"
        
        return xmp
    }
}
