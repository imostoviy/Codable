//
//  ATMsScreenViewController.swift
//  AwesomeCodableProject
//
//  Created by Мостовий Ігор on 10.01.19.
//  Copyright © 2019 Мостовий Ігор. All rights reserved.
//

import UIKit

class ATMsScreenViewController: UIViewController {

    //MAKR: private properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var SelectCityTextField: UITextField!
    private let cities: [String] = ["Lviv",
                            "Kyiv",
                            "Rivne",
                            "Vinnytsia",
                            "Cherkasy",
                            "Sumy",
                            "Dnipropetrovsk"]
    private var adresses: ATM? = nil
    private var selectedCity: String = ""
    private let cell = UINib(nibName: "ATMTableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPicker()
        createToolBar()
        selectedCity = cities[0]
        SelectCityTextField.text = cities[0]
        tableView.register(cell, forCellReuseIdentifier: ATMTableViewCell.reuseIdentifyer)
    }
    
    //MAKR: Functions for creating and customization  UIPicker
    func createPicker() {
        let cityPicker = UIPickerView()
        cityPicker.delegate = self
        SelectCityTextField.inputView = cityPicker
    }
    
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissEditin))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        SelectCityTextField.inputAccessoryView = toolbar
    }

    @objc func dismissEditin() {
        view.endEditing(true)
    }
    
    @IBAction func SearchButton(_ sender: UIButton) {
        Getdata.shared.getAtms(city: selectedCity) { (results) in
            self.adresses = results
            self.tableView.reloadData()
            
        }
    }
    
    
}

//MARK Extension UIPickerdelegate, UIPIckerDataSource
extension ATMsScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectCityTextField.text = cities[row]
        selectedCity = cities[row]
    }
}

// MARK: Extension UITableViewDataSource, UITableViewDelegate
extension ATMsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresses?.devices.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATMTableViewCell.reuseIdentifyer, for: indexPath) as! ATMTableViewCell
        cell.AdressUA.text = adresses?.devices[indexPath.row].fullAddressUa
        cell.AdressRu.text = adresses?.devices[indexPath.row].fullAddressRu
        cell.AdressUK.text = adresses?.devices[indexPath.row].fullAddressEn
        return cell
    }
    
    
}
