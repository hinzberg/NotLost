//
//  LocationView.swift
//  NotLost
//
//  Created by Holger Hinzberg on 18.04.22.
//

import SwiftUI

struct LocationView : UIViewRepresentable
{
    var text: String

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}


