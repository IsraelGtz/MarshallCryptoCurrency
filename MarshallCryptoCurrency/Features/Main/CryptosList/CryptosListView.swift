//
//  CryptosListView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct CryptosListView: View {
    @Namespace private var namespace
    let cryptos: [CryptoCurrency]
    let selectedExCur: ExchangeCurrency
    private let gridColumns = Array(repeating: GridItem(.adaptive(minimum: 150, maximum: 175), spacing: 24), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 24) {
                ForEach(cryptos) { crypto in
                    NavigationLink {
                        CryptoDetailView(
                            crypto: crypto,
                            exchangeCurrency: selectedExCur
                        )
                        .navigationTransition(.zoom(sourceID: crypto.id, in: namespace))
                    } label: {
                        CryptoCellView(
                            crypto: crypto,
                            exchangeCurrency: selectedExCur
                        )
                        .matchedTransitionSource(id: crypto.id, in: namespace)
                        .contextMenu {
                            Text("Historical data of 1 year")
                        } preview: {
                            CryptoHistoryView(
                                crypto: crypto,
                                exchangeCurrency: selectedExCur,
                                version: .preview
                            )
                        }
                    }
                    .scrollTransition { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.97)
                            .blur(radius: phase == .topLeading ? 3 : 0, opaque: phase.isIdentity ? false : true)
                            .blur(radius: phase == .bottomTrailing ? 2 : 0, opaque: phase.isIdentity ? false : true)
                    }
                }
            }
            .padding([.horizontal, .top])
        }
    }
}
