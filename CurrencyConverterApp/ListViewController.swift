//
//  ListViewController.swift
//  CurrencyConverterApp
//
//  Created by 김승태 on 2023/04/12.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var currencyTextFiled: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var rates: [(String, Double)]?
    
    var usdValue: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Currency Converter Picker"
        currencyTextFiled.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // cell이 별개일때 등록하는게 반드시 필요하다
        let nib = UINib(nibName: "CurrencyCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CurrencyCell")
        
        requestData()
    }
    
    func requestData() {
        
        RequestLayer.requestData { data in
            self.rates = data.rates?.sorted{ $0.key < $1.key }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension ListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.usdValue = Double(textField.text ?? "")
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        cell.leftLabel.text = self.rates?[indexPath.row].0
        
        let value = (self.rates?[indexPath.row].1 ?? 0) * (usdValue ?? 0)
        let resultValue = String(format: "%.2f", value)
        
        cell.rightLabel.text = resultValue.description
        
        return cell
    }
    
    
}
