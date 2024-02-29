//
//  TranslationViewController.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 19/09/2022.
//

import UIKit

class TranslationViewController: UIViewController {
    
    @IBOutlet weak var sourceFlag: UIImageView!
    @IBOutlet weak var targetFlag: UIImageView!
    @IBOutlet weak var resultArea: UITextView!
    @IBOutlet weak var sourceArea: UITextView!
    @IBOutlet weak var switchButton: UIImageView!
    @IBOutlet weak var translateButton: UIButton!
    
    var translation = Translation(session: URLSession.shared)
    // We store source language and target language in variables
    enum Language: String {case FR = "FR", EN = "EN"}
    private var source: Language.RawValue = Language.FR.rawValue
    private var target: Language.RawValue = Language.EN.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        improveDesign()
        // We add a tap gesture to the UIImage, to make it a button that allows to switch target language and source language
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.switchTranslation))
        self.switchButton.addGestureRecognizer(gesture)
    }
    
    // Function called when "translate" button is presseed
    @IBAction func Translate(_ sender: Any) {
        // We call the translate function that will call the translate API
        if let content =
            sourceArea.text {
            translation.getTranslation(text: content,source: source, target: target, then: { result, error in
                // If we successfully get result, we display it
                if let result: String = result {
                    DispatchQueue.main.async {
                        self.resultArea.text = result
                    }
                }
                // In case of error, we display an error
                if error != nil {
                    DispatchQueue.main.async {
                        let alert = Alert.createAlert(with: "il y a eu une erreur")
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
        
    }
    
    // Function that switch source language and target language
    @objc func switchTranslation() {
        
        
        if source == Language.FR.rawValue{
            target = Language.FR.rawValue
            source = Language.EN.rawValue
            sourceFlag.image = UIImage(named: "anglais")
            targetFlag.image = UIImage(named: "france")
        }
        else{
            target = Language.EN.rawValue
            source = Language.FR.rawValue
            sourceFlag.image = UIImage(named: "france")
            targetFlag.image = UIImage(named: "anglais")
        }
    }
    
    //func that rework a bit the design
    func improveDesign(){
        //We change a bit the application design by changing some borders and radius
        resultArea.layer.borderWidth = 0.3
        resultArea.layer.borderColor = UIColor.black.cgColor
        sourceArea.layer.borderWidth = 0.3
        sourceArea.layer.borderColor = UIColor.black.cgColor
        translateButton.layer.cornerRadius = 10
        resultArea.layer.cornerRadius = 10
        sourceArea.layer.cornerRadius = 10
    }
    
    //Function that dismiss the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceArea.resignFirstResponder()
    }
    
    
}

extension TranslationViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

