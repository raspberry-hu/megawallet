//
//  kaede.swift
//  megawallet
//
//  Created by hu on 2021/10/8.
//

import UIKit
import SwiftUI

struct kaedeTF:UIViewRepresentable{
    @Binding var text: String
    @Binding var placeholder:String
    typealias UIViewType = KaedeTextField

    func makeUIView(context: Context) -> KaedeTextField {
        let tf =  KaedeTextField()
        tf.placeholder = self.placeholder
        tf.foregroundColor = UIColor.gray
        tf.placeholderColor = UIColor.white
        tf.delegate = context.coordinator

        return tf
    }

    func updateUIView(_ uiView: KaedeTextField, context: Context) {

    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: kaedeTF

        init(_ textField: kaedeTF) {
            self.parent = textField
        }

        func updatefocus(textfield: UITextField) {
            textfield.becomeFirstResponder()
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {

             parent.text = textField.text ?? ""
            return true
        }

    }


}
