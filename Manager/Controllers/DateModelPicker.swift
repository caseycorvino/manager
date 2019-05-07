//
//  DateModelPicker.swift
//  extension
//
//  Created by Alex Li on 5/7/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class DateModelPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NSIntegerMax
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let df = DateFormatter()
        df.dateFormat = "dd"
        return df.string(for: Date()+TimeInterval(row * 86400))
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
