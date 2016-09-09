//
//  ViewController.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OptionDelegate {
    
    @IBOutlet weak var txt_View: UITextView!
    var mSize: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_View.textColor = UIColor.blackColor()
    }
    
    // Called from the PassingOptions controller via delegation
    func setColor(color: UIColor) {
        txt_View.textColor = color
    }
    
    func setBIU(type: String){
        switch type {
        case "B":
            txt_View.attributedText = attributedString(txt_View.text, type: "B")
        
            print(txt_View.font)
        case "I":
            txt_View.attributedText = attributedString(txt_View.text, type: "I")
            print(txt_View.font)
        case "U":
            let underline = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
            let underlineAttributedString = NSAttributedString(string: self.txt_View.text, attributes: underline)
            txt_View.attributedText = underlineAttributedString
            print(underlineAttributedString)
            
        default:
            txt_View.font = UIFont.italicSystemFontOfSize(CGFloat(mSize))
        }
    }
    
    func attributedString(txt: String, type: String) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize()
        var  attrStr: NSMutableAttributedString!
        
        let bold = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(fontSize),
            NSForegroundColorAttributeName: UIColor.blackColor()
        ]
        let italic = [
            NSFontAttributeName: UIFont.italicSystemFontOfSize(fontSize),
            NSForegroundColorAttributeName: UIColor.blackColor()
        ]
        if type == "B" {
            attrStr = NSMutableAttributedString(string: txt, attributes: bold)
        }
        if type == "I" {
            attrStr = NSMutableAttributedString(string: txt, attributes: italic)
        }
        return attrStr
    }
    
    //Called from the PassingOptions controller via NotificationCenter
    func alignment(notification: NSNotification) {
        //deal with notification.userInfo
        if let info = notification.userInfo as? Dictionary<String,Int> {
            // Check if value present before using it
            if let value = info["Align"] {
                txt_View.textAlignment = NSTextAlignment(rawValue: value)!
                print(value)
            }
            else {
                print("no value for key\n")
            }
            
        }
    }
    override func viewWillAppear(animated: Bool) {
        mSize = 0
        super.viewWillAppear(animated)
        //using singleton
        let option = OptionFont.sharedInstance
        if let size = option.size
        {
            self.mSize = size
            if let name = option.fontName
            {
                txt_View.font = UIFont(name: name, size: CGFloat(size))
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Options") {
            let destination = segue.destinationViewController as! PassingOptions
            //using strong counpling
            destination.option = OptionFont(size: Int((txt_View.font?.pointSize)!), fontName: (txt_View.font?.fontName)!, color: txt_View.textColor!, alignment: txt_View.textAlignment.rawValue, typeBIU: "I")
            //using delegate
            destination.delegate = self
            
            //using NotificationCenter
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "alignment:", name: "Alignment", object: nil)
            
            
            
            
            
            //using Block
            destination.setStyle({ (para1, para2) -> Void in
                print("p1:\(para1) p2:\(para2)")
            })
            
            
            
            
            
            
        } else {
            print("Unknown segue")
        }
    }
    
}

