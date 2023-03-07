//
//  SelectValueTableViewCell.swift
//  Example
//
//  Created by Amr Koritem on 07/03/2023.
//

import UIKit

class SelectValueTableViewCell: UITableViewCell {
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    
    private var isValueSelected = false {
        didSet {
            let iconImage = isValueSelected ? UIImage(systemName: "bell.fill") : UIImage(systemName: "bell")
            selectionButton.setImage(iconImage, for: .normal)
            valueLabel.textColor = isValueSelected ? .black : .lightGray
        }
    }
    private var selectValueHandler: (Bool) -> Void = { _ in }
    
    @IBAction func selectValue() {
        isValueSelected.toggle()
        selectValueHandler(isValueSelected)
    }
    
    func configure(valueText: String, isValueSelected: Bool, selectValueHandler: @escaping (Bool) -> Void) {
        valueLabel.text = valueText
        self.isValueSelected = isValueSelected
        self.selectValueHandler = selectValueHandler
    }
}
