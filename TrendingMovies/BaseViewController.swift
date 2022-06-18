//
//  BaseViewController.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import UIKit

protocol UIHandling{
    func styleUIComponents()
    func autoLayoutUIComponents()
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUIComponents()
        autoLayoutUIComponents()
    }
    
}

extension BaseViewController: UIHandling{
    func styleUIComponents() {
        // Style the UI Componentes here e.g. tables, Buttons, Labels,... etc
    }
    
    func autoLayoutUIComponents() {
        // handle the AutoLayout of UI components ( Anchors and constraints )
    }
    
    
}
