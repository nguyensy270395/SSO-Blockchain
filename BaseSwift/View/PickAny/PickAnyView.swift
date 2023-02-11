//
//  PickAnyView.swift
//  gurume_go_ios
//
//  Created by Nguyen Thanh Sy on 07/07/2022.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxRelay

class PickAnyView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    private var data: [String] = []
    static let shared = PickAnyView()
    var completion: ((String) -> Void)? = nil
    
    @IBOutlet weak var contentView: UIView!
    @IBAction func cancel(_ sender: Any) {
        hide()
    }
    @IBAction func done(_ sender: Any) {
        completion?(data[picker.selectedRow(inComponent: 0)])
        hide()
    }
    @IBOutlet weak var picker: UIPickerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
        picker.dataSource = self
        picker.delegate = self
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
    }
    private func initXib() {
        fromNib()
      
    }
    func hide() {
        self.backgroundColor = .clear
        self.hideWithAnimationToBottom(animatedView: self.contentView, callback: nil)
    }
    func show(data: [String], position: Int = -1, completion: ((String) -> Void)? = nil) {
        self.data = data
        if position != -1 {
            picker.selectRow(position, inComponent: 0, animated: false)
        }
        picker.reloadComponent(0)
        self.completion = completion
        self.showWithAnimationFromBottom(animatedView: self.contentView, in: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
            if let v = view {
                label = v as? UILabel ?? UILabel()
            }
        label.text = data[row]
        label.textAlignment = .center
        return label
    }
}
