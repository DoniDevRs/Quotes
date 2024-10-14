//
//  ViewController.swift
//  QuotesApp
//
//  Created by Doni Silva on 24/08/24.
//

import UIKit

public class QuotesViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private var quotesView: QuotesView?
    private let quotesManager = QuotesManager()
    private let userConfig = UserConfiguration.shared
    private var timer: Timer?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    private func setup() {
        self.quotesView = QuotesView()
        self.view = quotesView
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    private func formatView() {
        quotesView?.view.backgroundColor = userConfig.colorScheme == 0 ? .white : .backgroundDark
        quotesView?.quoteLabel.textColor = userConfig.colorScheme == 0 ? .black : .white
        quotesView?.authorLabel.textColor = userConfig.colorScheme == 0 ? .appPrimary : .yellow
        prepareQuote()
    }
    
    private func prepareQuote() {
        timer?.invalidate()
        if userConfig.autoRefresh {
            timer = Timer.scheduledTimer(withTimeInterval: userConfig.timeInterval, repeats: true, block: { (timer) in
                self.quotesView?.animate(quote: self.quotesManager.getRandomQuote())
            })
        }
        quotesView?.animate(quote: quotesManager.getRandomQuote())
    }
}
