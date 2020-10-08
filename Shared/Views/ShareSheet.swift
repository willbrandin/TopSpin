//
//  SwiftUIView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 10/7/20.
//

import SwiftUI
import UIKit

#if os(iOS)
struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    var sharing: [Any]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        let v = UIActivityViewController(activityItems: sharing, applicationActivities: nil)
        v.modalPresentationStyle = .pageSheet
        return v
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {

    }
}
#endif
