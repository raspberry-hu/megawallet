//
//  WalletConnectView.swift
//  megav2
//
//  Created by hu on 2021/11/3.
//

import SwiftUI

struct TestView: UIViewRepresentable {
    func updateUIView(_ uiView: ResponderView, context: Context) {
        print("1")
    }
    
    func makeUIView(context: Context) -> ResponderView{
        return ResponderView()
    }
}

struct TestViewController: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: ResponderViewController, context: Context) {
        print("1")
    }
    
    typealias UIViewControllerType = ResponderViewController
    
   func makeUIViewController(context: Context) -> ResponderViewController {
            let vc = ResponderViewController()
            return vc
    }
}

struct WalletConnectView: View {
    var body: some View {
        TestViewController()
    }
}

struct WalletConnectView_Previews: PreviewProvider {
    static var previews: some View {
        WalletConnectView()
    }
}
