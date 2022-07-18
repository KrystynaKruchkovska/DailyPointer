//
//  PopUP.swift
//  DailyPointer
//
//  Created by Paweł on 14/07/2022.
//

import UIKit

class PopUpViewController: UIViewController, ViewActionDelegate{
    var animationHandler: ((Bool) -> ())?
    
    private var popup: Popup? {
        return view as? Popup
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        popup?.delegate = self
        view = Popup(titleText: "Check your email")
        animationHandler = { (finished) in
            if finished {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
            
        }
    }
}
