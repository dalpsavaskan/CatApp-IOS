//
//  File.swift
//  MyKittens
//
//  Created by Deniz Alp Savaskan on 13.12.2018.
//  Copyright © 2018 Deniz Alp Savaskan. All rights reserved.
//

import UIKit

class CustomButton: UIButton{
    
    var myValue: Int
    
    required init?(value: Int = 0) {
        self.myValue = value
        super.init(frame: .zero)
    }
    required init?(coder aDecoder: NSCoder) {
        self.myValue = 0
        super.init(coder: aDecoder)
    }
}
