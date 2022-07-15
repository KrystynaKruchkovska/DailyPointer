//
//  Popup.swift
//  DailyPointer
//
//  Created by Paweł on 14/07/2022.
//

import UIKit

protocol ViewActionDelegate {
    var animationHandler: ((Bool)->())? { get set }
}

class Popup: UIView {
    
    var titleText: String
    var delegate: ViewActionDelegate?
    
    init(titleText: String) {
        self.titleText = titleText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        var label = UILabel(text: titleText, textAlignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .medium))
        return label
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [titleLabel], axis: .vertical, spacing: 16, alignment: .center, distribution: .equalSpacing)
        return stackView
    }()
    
    fileprivate var container: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    fileprivate func setupView() {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.addSubview(container)
        self.container.addSubview(stackView)
            
        container.anchor(canterXAnchor: self.centerXAnchor, canterYAnchor: self.centerYAnchor, widthConstant: (self.frame.width * 0.7), heightConstant: (self.frame.height * 0.45))
        
        stackView.anchor(canterXAnchor: container.centerXAnchor, canterYAnchor: container.centerYAnchor, widthConstant: (container.frame.width * 0.8), heightConstant: (container.frame.height * 0.8))
    }
    
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { isComplete in
            if isComplete {
                self.delegate?.animationHandler?(true)
                self.removeFromSuperview()
            }
        }

    }
}
