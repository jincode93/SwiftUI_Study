//
//  MyVStack.swift
//  HelloSwiftUI
//
//  Created by 진준호 on 2022/10/19.
//

import SwiftUI

struct MyVStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 20) {
            content()
        }
        .bold()
        .font(.title)
    }
}
