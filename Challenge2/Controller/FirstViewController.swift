//
//  FirstViewController.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 28.08.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let firstView = FirstView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(firstView)
        self.firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.backgroundColor = .black
        setupConstraints()
    }

    func setupConstraints () {
        NSLayoutConstraint.activate([
            self.firstView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.firstView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.firstView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.firstView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
