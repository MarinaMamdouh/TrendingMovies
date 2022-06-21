//
//  BaseViewController.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import UIKit

class BaseViewController: UIViewController, UIHandling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        styleUIComponents()
        autoLayoutUIComponents()
    }
    
    func styleUIComponents() {
        // Style the UI Componentes here e.g. tables, Buttons, Labels,... etc
    }
    
    func autoLayoutUIComponents() {
        // handle the AutoLayout of UI components ( Anchors and constraints )
    }
    
}
