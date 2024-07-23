//
//  UCProgressView.swift
//  UnderControl
//
//  Created by Desarrollo on 22/07/24.
//

import SwiftUI

struct UCProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color("violet_700")))
            .controlSize(.large)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background { Color.gray.opacity(0.3) }
    }
}

#Preview {
    UCProgressView()
}
