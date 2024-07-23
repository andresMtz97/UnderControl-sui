//
//  CategoryItem.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import SwiftUI

struct CategoryItem: View {
    var category: CategoryDto
    var body: some View {
        Text(category.name)
    }
}

#Preview {
    CategoryItem(category: CategoryDto(id: nil, name: "Prueba categoria", type: true, userId: nil))
}
