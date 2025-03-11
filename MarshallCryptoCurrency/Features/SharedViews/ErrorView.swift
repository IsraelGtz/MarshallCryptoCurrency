//
//  ErrorView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let isReloadButtonShown: Bool
    let reloadAction: (() -> Void)?

    init(error: Error, isReloadButtonShown: Bool = true, reloadAction: (() -> Void)?) {
        self.error = error
        self.isReloadButtonShown = isReloadButtonShown
        self.reloadAction = reloadAction
    }

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Text("An error ocurred.")
                    Text(error.localizedDescription)
                }
                Spacer()
            }
            if let reloadAction,
               isReloadButtonShown
            {
                Button {
                    reloadAction()
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .font(.system(size: 28))
                        .fontWeight(.light)
                }
            }
            Spacer()
        }
    }
}
