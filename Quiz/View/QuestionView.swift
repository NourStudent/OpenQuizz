//
//  QuestionView.swift
//  Quiz
//
//  Created by user172836 on 6/26/20.
//  Copyright © 2020 user172836. All rights reserved.
//

import UIKit

class QuestionView: UIView {

  @IBOutlet private var label:UILabel!
  @IBOutlet private var icon : UIImageView!
    
    enum Style {
        case correct, incorrect, standard
    }
    var style: Style = .standard {
    didSet {
        setStyle(style)
    }
}

private func setStyle(_ style: Style) {
    switch style {
    case .correct:
        backgroundColor = UIColor(red: 200.0/255.0, green: 236.0/255.0, blue: 160.0/255.0, alpha: 1)
        icon.image = UIImage(named:"Icon Correct")
        icon.isHidden = false
    case .incorrect:
        backgroundColor = #colorLiteral(red: 0.9544174075, green: 0.5278146863, blue: 0.5794272423, alpha: 1)
        icon.image = #imageLiteral(resourceName: "Icon Error")
         icon.isHidden = false
    case .standard:
        backgroundColor = #colorLiteral(red: 0.7488923669, green: 0.7690133452, blue: 0.7889612317, alpha: 1)
         icon.isHidden = true
    }
}
    
    
    
    var title = ""{
     didSet {
        label.text = title
    }
}
}
