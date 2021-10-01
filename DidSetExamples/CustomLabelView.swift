//
//  CustomLabelView.swift
//  DidSetExamples
//
//  Created by daanff on 2021-09-30.
//

import UIKit

class CustomLabelView: UIView {

    var score = "0"{
        didSet{
            label.text = score
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(label)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32)
        label.text = score
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

}
