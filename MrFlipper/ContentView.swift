//
//  ContentView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
    
        HStack {
            Image("apple")
                .resizable()
                .frame(minWidth: 70, idealWidth: 100, maxWidth: 120, minHeight: 140, idealHeight: 200, maxHeight: 240)
                .scaledToFit()
                .border(.black)
            
            Image("bell")
                .resizable()
                .frame(minWidth: 70, idealWidth: 100, maxWidth: 120, minHeight: 140, idealHeight: 200, maxHeight: 240)
                .scaledToFit()
                .border(.black)
            
            Image("cherry")
                .resizable()
                .frame(minWidth: 70, idealWidth: 100, maxWidth: 120, minHeight: 140, idealHeight: 200, maxHeight: 240)
                .scaledToFit()
                .border(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
