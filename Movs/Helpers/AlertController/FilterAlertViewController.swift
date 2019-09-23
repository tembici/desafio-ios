//
//  FilterAlertViewController.swift
//  Movs
//
//  Created by Miguel Pimentel on 23/09/19.
//  Copyright © 2019 Miguel Pimentel. All rights reserved.
//

import UIKit

protocol FilterAlertDelegate: class {
    func dismissAlert()
    func filterRequested(for value: Any)
}

class FilterAlertViewController: UIViewController {
    
    var delegate: FilterAlertDelegate?
    
    let content = ["1950", "1003"]
    
    private var selectedValue: Any?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func cancelButtonPressed(_ sender: Any) { self.delegate?.dismissAlert() }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if let data = self.selectedValue {
             self.delegate?.filterRequested(for: data)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(delegate: FilterAlertDelegate) {
        self.init()
        self.delegate = delegate
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private -
    
    private func setup() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
}

extension FilterAlertViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return content[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedValue = self.content[row]
    }
}


extension FilterAlertViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return content.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
}
