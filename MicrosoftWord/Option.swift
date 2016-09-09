//
//  Option.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
class OptionFont {
    var size: Int?
    var fontName: String?
    var color: UIColor?
    var alignment: Int!
    var typeBIU: String!
    init (size: Int, fontName: String, color: UIColor, alignment: Int, typeBIU: String)
    {
        self.size = size
        self.fontName = fontName
        self.color = color
        self.alignment = alignment
        self.typeBIU = typeBIU
    }
    class var sharedInstance: OptionFont {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: OptionFont? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = OptionFont()
        }
        return Static.instance!
    }
    init()
    {}
}