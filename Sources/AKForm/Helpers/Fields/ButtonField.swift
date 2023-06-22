//
//  ButtonField.swift
//  AKForm
//
//  Created by Amr Koritem on 07/03/2023.
//

import UIKit

/// `ButtonField` properties wrapper.
/// Use this class when you want a field that contains a cell wide button.
public class ButtonField: Field {
    let actionHandler: () -> Void

    /// Initializer for `ButtonField`.
    /// - Parameters:
    ///   - id: Determines the id of the field.
    ///   - count: Determines if the cell will have single or double fields.
    ///   - contentType: Determines the content data type of the field.
    ///   - labelStyle: Style for the field label.
    ///   - fieldStyle: Style for the data field.
    ///   - texts: The fixed string texts used for the field such as the field label, placeholder, etc.
    ///   - mandatoryStyle: Determines if the field is mandatory as well as the style used to show the mandatory status of the field.
    ///   - firstResponderStyle: Styles to be used when the field content is being changed.
    ///   - validationHandler: Custom validation handler for the field data.
    ///   - actionHandler: Custom button action.
    public init(
        id: Int,
        count: FieldCount = .uni,
        contentType: Field.ContentType,
        labelStyle: LabelStyle = LabelStyle(),
        fieldStyle: FieldStyle = FieldStyle(),
        texts: Texts,
        mandatoryStyle: MandatoryStyle = MandatoryStyle(),
        firstResponderStyle: FirstResponderStyle? = Default.firstResponderStyle,
        validationHandler: ValidationHandler? = nil,
        actionHandler: @escaping () -> Void
    ) {
        self.actionHandler = actionHandler
        super.init(
            id: id,
            count: count,
            type: .sheet,
            contentType: contentType,
            labelStyle: labelStyle,
            fieldStyle: fieldStyle,
            texts: texts,
            mandatoryStyle: mandatoryStyle,
            firstResponderStyle: firstResponderStyle,
            validationHandler: validationHandler
        )
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath,
        dataSetter: @escaping (String?) -> Void,
        dataGetter: @escaping () -> String?
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ButtonFieldTableViewCell.reuseIdentifier)
        let fieldCell = cell as? ButtonFieldTableViewCell
        fieldCell?.configure(
            field: self,
            fieldText: dataGetter() ?? "",
            buttonActionHandler: actionHandler
        )
        return cell ?? UITableViewCell()
    }
}
