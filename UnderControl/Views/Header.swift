//
//  Header.swift
//  UnderControl
//
//  Created by Desarrollo on 25/07/24.
//

import SwiftUI

struct Header: View {
    private var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text("Under Control")
                .font(.system(size: 50))
                .foregroundStyle(Color.white)
                .bold()
            Text(title)
                .font(.system(size: 30))
                .foregroundStyle(Color.white)
        }
        .padding(.top, 30)
        .frame(width: UIScreen.main.bounds.width * 3, height: 300)
        .background {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color("violet_500"))
                .rotationEffect(Angle(degrees: 15))
        }
        .offset(y: -100)
    }
}

#Preview {
    Header("Sign in")
}
