//
//  ErrorView.swift
//  TrendingMovies
//
//  Created by Marina on 21/06/2022.
//

import UIKit

// use this protocol when using ErrorView inside the ViewController or ParentView
protocol ErrorViewDelegate {
    // called when TryAgain button is clicked in ErrorView
    func didClickTryAgain()
}

class ErrorView: UIView {
    
    var delegate: ErrorViewDelegate?
    var errorMessage: String! {
        didSet {
            updateErrorMessage()
        }
    }
    private let nibName = Constants.errorViewNibName
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // update the errorMessage label while drawing the view
        updateErrorMessage()
    }
    
    private func updateErrorMessage() {
        if let msg = errorMessage {
            errorMessageLabel.text = msg
        }
    }
    
    // get the design of XIB file
    private func commonInit() {
        guard let viewFromXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as? UIView else {
            return
        }
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    
    }
    
    @IBAction func tryAgainButtonClicked(_ sender: Any) {
        
        delegate?.didClickTryAgain()
        
    }
    
}
