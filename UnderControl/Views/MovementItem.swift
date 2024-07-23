//
//  MovementItem.swift
//  UnderControl
//
//  Created by Desarrollo on 23/07/24.
//

import SwiftUI

struct MovementItem: View {
    var movement: MovementDto
    var body: some View {
        HStack {
            VStack {
                Text(movement.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                HStack {
                    Text(movement.amount.toCurrency())
                        .font(.title3)
                    if let transaction = movement.transaction, let category = transaction.category {
                        Text(category.name)
                            .padding(.leading)
                            .font(.callout)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(movement.account?.name ?? "")
                        .font(.caption)
                        .padding(.leading)
                    if let transfer = movement.transfer {
                        Image(systemName: "arrow.forward")
                        Text(transfer.account.name)
                            .font(.caption)
                    }
                    Spacer()
                    Text(movement.date)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Spacer()
            
            if let transaction = movement.transaction {
                if transaction.type {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
            } else if movement.transfer != nil {
                Image(systemName: "arrow.left.arrow.right.square")
                    .resizable()
                    .scaledToFit()
                    .padding(4)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
        }
        .padding(0.5)
        
    }
}

#Preview {
    MovementItem(
        movement: MovementDto(
            id: nil,
            amount: "10000.0",
            date: "yyyy-MM-dd",
            description: "Transporte",
            accountId: 2,
            account: AccountDto(
                id: nil,
                name: "BBVA",
                balance: ""
            ),
            transaction: TransactionDto(
                id: nil,
                type: true,
                category: CategoryDto(
                    id: nil,
                    name: "Transporte",
                    type: true,
                    userId: nil
                )
            ), transfer: TransferDto(
                id: nil,
                accountId: 0,
                account: AccountDto(
                    id: 0,
                    name: "NU",
                    balance: ""
                )
            )
        )
    )
}
