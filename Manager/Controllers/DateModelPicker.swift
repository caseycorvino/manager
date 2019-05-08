//
//  DateModelPicker.swift
//  extension
//
//  Created by Alex Li on 5/7/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class DateModelPicker: UIPickerView, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 365
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
