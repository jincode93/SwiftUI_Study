//
//  TitleView.swift
//  HelloSwiftUI
//
//  Created by 진준호 on 2022/10/18.
//

import SwiftUI

struct TitleView: View {
    var colors: [Color] = [.blue, .purple, .red, .cyan, .green, .orange, .gray, .pink]
    
    @ObservedObject var colorIndex = ColorIndex()
    
    var body: some View {
        MyVStack {
            Button(action: {
                colorIndex.changeColor()
            }, label: {
                Image(systemName: "pawprint.fill")
                    .foregroundColor(.init(uiColor: #colorLiteral(red: 1, green: 0.7645270228, blue: 0.9772198796, alpha: 1)))
                    .font(.system(size: 100))
            })
            Text("☀️Team Eleven☁️")
                .foregroundColor(.indigo)
                .padding()
            MyVStack {
                Text("🐯 민경")
                    .foregroundColor(colors[(colorIndex.index + 0)%colors.count])
                Text("🐰 예슬")
                    .foregroundColor(colors[(colorIndex.index + 1)%colors.count])
                Text("🐯 은노")
                    .foregroundColor(colors[(colorIndex.index + 2)%colors.count])
                Text("🐵 준호")
                    .foregroundColor(colors[(colorIndex.index + 3)%colors.count])
                Text("🐯 진아")
                    .foregroundColor(colors[(colorIndex.index + 4)%colors.count])
                Text("🐮 근섭")
                    .foregroundColor(colors[(colorIndex.index + 5)%colors.count])
                Text("🐯 정훈")
                    .foregroundColor(colors[(colorIndex.index + 6)%colors.count])
                Text("🐯 종현")
                    .foregroundColor(colors[(colorIndex.index + 7)%colors.count])
            }
        }
    }
}

class ColorIndex: ObservableObject {
    @Published var index: Int = 0
    
    func changeColor() {
        index += 1
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
