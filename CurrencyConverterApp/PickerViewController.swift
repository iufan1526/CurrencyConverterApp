//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by 김승태 on 2023/04/12.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var usdCurrencyTextFiled: UITextField!
    @IBOutlet weak var selectCurrencyTextFiled: UITextField!
    @IBOutlet weak var selectedCurrencyName: UILabel!
    
    var rates: [(String, Double)]?
    
    var selectedRow = 0 {
        didSet {
            selectedCurrencyName.text = rates?[selectedRow].0
            selectCurrencyTextFiled.text = calculateCurrency()
        }
    }
    
    func calculateCurrency() -> String {
        let selectedValue = rates?[selectedRow].1 ?? 0
        let usdValue = Double(usdCurrencyTextFiled.text ?? "") ?? 0
        let resultValue = String(format: "%.2f", (selectedValue * usdValue))
        
        return resultValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Currency Converter Picker"

        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        usdCurrencyTextFiled.delegate = self
        
        requestData()
    }
    
    func requestData() {
        
        RequestLayer.requestData { model in
            self.rates = model.rates?.sorted{ $0.key < $1.key }
            
            DispatchQueue.main.async {
                self.currencyPicker.reloadAllComponents()
            }
        }
    }


}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let key = rates?[row].0 ?? ""
        let value = rates?[row].1.description ?? ""
        
        return key
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRow = row
    }
}

extension PickerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectCurrencyTextFiled.text = calculateCurrency()
    }
}


