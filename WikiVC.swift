//
//  WikiVC.swift
//  Bleach
//
//  Created by Fiona Au on 12/1/21.
//

import UIKit
import WebKit

class WikiVC: UIViewController {

    @IBOutlet var urlInputTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton?.setTitle(NSLocalizedString("goButton", comment: ""), for: .normal)
        goButton?.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 15)

        urlInputTextField?.text = "https://bleach.fandom.com/wiki/Bleach_Wiki"
        urlInputTextField?.font = UIFont(name: "HiraginoSans-W6", size: 12)
        loadRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: darkMode) {
            overrideUserInterfaceStyle = .dark
            self.view.backgroundColor = UIColor.black
            self.urlInputTextField.backgroundColor = UIColor(named: "yellowish")
            self.urlInputTextField.textColor = UIColor(named: "hollowRed")
        } else {
            overrideUserInterfaceStyle = .light
            self.view.backgroundColor = UIColor.white
            self.urlInputTextField.backgroundColor = UIColor.systemFill
//            self.urlInputTextField.backgroundColor = UIColor.link
            self.urlInputTextField.textColor = UIColor.black
        }
    }
    
    func loadRequest() { // gets triggered when onGo is pressed
        if let address = urlInputTextField?.text, let url = URL(string: address) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func onGo(_ sender: UIButton) {
        loadRequest()
    }
}

