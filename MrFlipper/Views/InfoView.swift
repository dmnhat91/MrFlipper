//
//  InfoView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 29/08/2022.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            
        }.onAppear {
            playSound(sound: "bg-music", type: "mp3")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
