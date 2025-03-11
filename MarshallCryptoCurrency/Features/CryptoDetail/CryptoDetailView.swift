//
//  CryptoDetailView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import CryptoCurrencyService
import SwiftUI

struct CryptoDetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    // webview values
    @State private var isShowingAlert: Bool = false
    @State private var isWebPresented: Bool = false
    @State private var isWebLoading: Bool = false

    // As we only pass 'crypto' and 'exCur' with no processing I decided to avoid the usage of a view model
    private let crypto: CryptoCurrency
    private let exCur: ExchangeCurrency

    init(
        crypto: CryptoCurrency,
        exchangeCurrency: ExchangeCurrency
    ) {
        self.crypto = crypto
        exCur = exchangeCurrency
    }

    var body: some View {
        ScrollView {
            VStack {
                CryptoInfoView(
                    crypto: crypto,
                    exCur: exCur
                )
                CryptoHistoryView(
                    crypto: crypto,
                    exchangeCurrency: exCur
                )
                openWebButton
            }
        }
        .navigationTitle(crypto.name)
        .toolbarBackground(colorScheme == .dark ? .black : .white, for: .navigationBar)
    }

    @ViewBuilder
    private var openWebButton: some View {
        if let strURL = crypto.explorer,
           let url = URL(string: strURL)
        {
            Button {
                isShowingAlert = true
            } label: {
                Text("Visit crypto's webpage")
            }
            .padding()
            .alert("The webpage of this crypto will be opened \nDo you want to continue?", isPresented: $isShowingAlert, actions: {
                Button("Yes") {
                    isWebPresented = true
                }
                Button("No", role: .cancel) {}
            }, message: {
                Text("For security reasons some actions inside the webpage will be blocked.")
            })
            .navigationDestination(isPresented: $isWebPresented) {
                WebView(url: url)
            }
        }
    }
}
