//
//  ConversionViewController.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 19/09/2022.
//

import UIKit

class ConversionViewController: UIViewController{
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var from: UIPickerView!
    @IBOutlet weak var to: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    
    private var allCurrencies: [String] = []
    
    let conversion = Conversion(session: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        improveDesign()
        displayCurrencies()
    }
    
    //Function that dismiss the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amount.resignFirstResponder()
    }
    
    //function that call "getCurrencies" function
    func displayCurrencies(){
        // Function that get all availables currencies we need to put in the pickers views
        conversion.getCurrencies(then: { currencie, error in
            // if function return the currencies, we can display it
            if let currencie = currencie{
                self.allCurrencies = currencie
                DispatchQueue.main.async {
                    self.from.reloadComponent(0)
                    self.to.reloadComponent(0)
                }
            }
            // In case of error, we display an error
            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    let alert = Alert.createAlert(with: error.localizedDescription)
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    // Function called when user click on "convert" button
    @IBAction func displayConversion() {
        
        // call the function that convert from a currencie to another one if user writed an amount
        if let amount = amount.text, from != nil, to != nil, allCurrencies.count > 0 {
            
            let from = allCurrencies [from.selectedRow(inComponent: 0)]
            let to = allCurrencies [to.selectedRow(inComponent: 0)]
            
            // We call the function that will call the API to make the conversion
            conversion.convert(amount: amount, from: from, to: to) { [weak self] result, error in
                // If the conversion is a success, we display the result
                if let result: Double = result {
                    DispatchQueue.main.async {
                        self?.label.text = String(result)
                    }
                }
                
                // In case of error, we display an error
                if let error = error {
                    DispatchQueue.main.async {
                        let alert = Alert.createAlert(with: error.localizedDescription)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
        }
        // In case of error, we display an error
        else {
            DispatchQueue.main.async {
                let alert = Alert.createAlert(with: "La conversion à échouée")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    //func that rework a bit the design
    func improveDesign(){
        // add some radius for design
        convertButton.layer.cornerRadius = 10
        amount.layer.borderWidth = 0.3
        amount.layer.borderColor = UIColor.black.cgColor
        amount.layer.cornerRadius = 10
        label.layer.borderWidth = 0.3
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 10
    }
}
    
    // Data source and delegate for Pickers View so it knows what to display
    extension ConversionViewController: UIPickerViewDataSource{
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return allCurrencies.count
        }
        
        
    }
    
    extension ConversionViewController: UIPickerViewDelegate{
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return allCurrencies[row]
        }
        
    }


extension ConversionViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



   


