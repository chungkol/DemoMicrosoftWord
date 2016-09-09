//
//  PassingOptions.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
protocol OptionDelegate {
    func setColor(colorName: UIColor);
    func setBIU(type: String)
}
class PassingOptions: UIViewController {
    @IBOutlet weak var currentFontName: UITextField!
    @IBOutlet weak var currentSize: UITextField!
    @IBOutlet weak var currentBIU: UILabel!
    @IBOutlet weak var currentColor: UILabel!
    @IBOutlet weak var currentAlign: UILabel!
    var delegate : OptionDelegate! = nil
    var colorLabelText : String! = nil
    var option :  OptionFont!
    var completion: ((para1: String, para2: String) -> (Void))?
    
    override func viewDidLoad() {
        currentFontName.text = option.fontName
        currentSize.text = String(option.size!)
        currentColor.backgroundColor = option.color
        currentBIU.text = option.typeBIU
        var align = ""
        switch(option.alignment)
        {
            case 0: align = "Lef"
            case 1: align = "Cen"
            case 2: align = "Rig"
            default: break
        }
        currentAlign.text = align
    }
    override func viewWillDisappear(animated: Bool) {
        //using singleton
        let option = OptionFont.sharedInstance
        option.size = Int(currentSize.text!)
        option.fontName = currentFontName.text
        self.completion!(para1:"1", para2: "2")
    }
    
    //using delegate
    @IBAction func touchUpInsideSelectedColor(sender: UIButton) {
        if let color = sender.backgroundColor {
            currentColor.backgroundColor = color
            delegate.setColor(color)
        }
    }
    
    
    //using notificationCenter
    @IBAction func touchUpInsideSystemFont(sender: UIButton) {
        currentAlign.text = sender.titleLabel?.text
        let dic: NSDictionary = ["Align": sender.tag - 100]
        NSNotificationCenter.defaultCenter().postNotificationName("Alignment", object: nil, userInfo: dic as [NSObject : AnyObject])
    }
    
    
    
    
    
    
    
    
    
    //using Block
    func setStyle(completion: ((para1: String, para2: String) -> Void)?)
    {
        print("action")
        self.completion = completion
    }
    
    
    @IBAction func touchUpInsideBIU(sender: UIButton) {
        if let type = sender.titleLabel?.text {
            currentBIU.text = type
            delegate.setBIU(type)
        }
        
        
    }
    
    
    
    
    
    
}
