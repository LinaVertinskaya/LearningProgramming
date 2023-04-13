//
//  WebView.swift
//  LearningProgramming
//
//  Created by Лина Вертинская on 12.03.23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    @Binding var url: String
    var isLoad: (Bool) -> ()

    func makeUIView(context: Context) -> some UIView {

        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        if let openUrl = URL(string: url) {
            var urlComponent = URLComponents(url: openUrl, resolvingAgainstBaseURL: true)
            let request = URLRequest(url: urlComponent?.url ?? openUrl)
            webView.load(request)
        }

        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator { isLoad in
            self.isLoad(isLoad)
        }
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {

    let isLoad: (Bool) -> ()

    init(isLoad: @escaping (Bool) -> ()) {
        self.isLoad = isLoad
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoad(true)
    }
}
