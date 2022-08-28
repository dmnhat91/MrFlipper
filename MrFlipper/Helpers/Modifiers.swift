//
//  Modifiers.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct gameTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 5)
            .font(.system(.body, design: .rounded))
            .foregroundColor(Color("RedDark"))
    }
}
