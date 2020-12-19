//
//  Colors.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import SwiftUI

class Colors {
    var cs: ColorScheme
    init(_ cs: ColorScheme) {
        self.cs = cs
    }
    private func select<T>(_ l: T, _ d: T) -> T {
        return cs == .light ? l : d
    }
    //Navigation-Related
    func overallTextFC() -> Color {
        return select(.black, .white)
    }
    func navBarLargeBC() -> Color {
        return select(.white, .black)
    }
    func navBarSmallBC() -> LinearGradient {
        
        return select(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6944319935, green: 0.7768305019, blue: 0.8972821162, alpha: 1)), Color(#colorLiteral(red: 0.6199758414, green: 0.6820788235, blue: 0.7952757028, alpha: 1))]), startPoint: .top, endPoint: .bottom),
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.01628011984, green: 0.01795927074, blue: 0.0385798745, alpha: 1)), Color(#colorLiteral(red: 0.06165876531, green: 0.08683248652, blue: 0.1526152268, alpha: 1)), Color(#colorLiteral(red: 0.01628011984, green: 0.01795927074, blue: 0.0385798745, alpha: 1))]), startPoint: .top, endPoint: .bottom))
    }
    func backBtnFC() -> Color {
        return select(Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.185295701, green: 0.4871408343, blue: 0.9665109515, alpha: 1)))
    }
    func tabBarBC() -> Color {
        return select(Color(#colorLiteral(red: 0.9678314328, green: 0.9649544358, blue: 0.9647228122, alpha: 1)), Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)))
    }
    func bannerAdBC() -> Color {
        return select(.white, .black)
    }
    
    //Alert-Related
    func alertBC() -> Color {
        return select(Color(#colorLiteral(red: 0.9019607843, green: 0.9176470588, blue: 0.9294117647, alpha: 1)),Color(#colorLiteral(red: 0.9019607843, green: 0.9176470588, blue: 0.9294117647, alpha: 1)))
    }
    func alertDefaultBtnBC() -> Color {
        return select(Color(#colorLiteral(red: 0.1529411765, green: 0.5058823529, blue: 0.8588235294, alpha: 1)),Color(#colorLiteral(red: 0.1529411765, green: 0.5058823529, blue: 0.8588235294, alpha: 1)))
    }
    func alertDestructBtnBC() -> Color {
        return select(Color(#colorLiteral(red: 0.9137254902, green: 0.2549019608, blue: 0.2, alpha: 1)),Color(#colorLiteral(red: 0.9137254902, green: 0.2549019608, blue: 0.2, alpha: 1)))
    }
    
}
