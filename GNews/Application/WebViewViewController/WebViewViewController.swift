//
//  WebViewViewController.swift
//  GNews
//
//  Created by Aleksey on 03.04.2022.
//

import Foundation
import WebKit

class WebViewViewController: BaseViewController {
    
    // MARK: - UI
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    // MARK: - Init
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        webView.load(URLRequest(url: url))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    override func viewWillAppear(_ animated: Bool) {
        updateNavigationBar()
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
