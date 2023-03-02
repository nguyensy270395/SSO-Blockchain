//
//  BaseView.swift
//  lovediary
//
//  Created by daovu on 10/03/2021.
//

import UIKit
import RxSwift

class BaseView: UIView {
    let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {}

}
