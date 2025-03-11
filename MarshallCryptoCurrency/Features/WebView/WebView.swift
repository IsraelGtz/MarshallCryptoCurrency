//
//  WebView.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import SwiftUI

struct WebView: View {
    let url: URL
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            ZStack {
                WebViewSwiftUI(
                    url: url,
                    isLoading: $isLoading
                )
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}
