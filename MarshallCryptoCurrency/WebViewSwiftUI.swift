//
//  WebViewSwiftUI.swift
//  MarshallCryptoCurrency
//
//  Created by Israel Gutiérrez Castillo.
//

import SwiftUI
import WebKit

struct WebViewSwiftUI: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    final class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewSwiftUI

        init(_ parent: WebViewSwiftUI) {
            self.parent = parent
        }

        func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_: WKWebView, didFinish _: WKNavigation!) {
            parent.isLoading = false
        }

        func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
            switch navigationAction.navigationType {
            case .linkActivated,
                 .formSubmitted,
                 .formResubmitted:
                decisionHandler(.cancel)
            case .backForward,
                 .reload,
                 .other:
                decisionHandler(.allow)
            @unknown default:
                decisionHandler(.cancel)
            }
        }

        func webView(_: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError _: Error) {
            // Here we can catch/pass/process the error
            // For this case I will do nothing
            parent.isLoading = false
        }
    }
}
