//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Yurii Sameliuk on 10/02/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import UIKit
 
      // 1) - Request & Session
      // 2) - Response & Data
      // 3) - Parsing & JSON Serialization

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbrLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesButton(_ sender: Any) {
        // 1)
      // 4tobu na4at raboty s API nyžno sordat URL
        // WAŽNO!!! 4tobusdelat zapros na http wmesto https nyžno w info.plist sozdat "App Transport Security Settings" i y nego wubrat opcujy "Allow Arbitrary Loads" ystanowiw value na YES
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=b4e752d4b09792e3b3117812ba01e9da")
        
        // dalee sozdaem sesijy URL
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2)
                if data != nil {
                    do {
                        // poly4aem dannue. wse wupolniaetsia w fonowom režume
                        let jsonResponce = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        
                        DispatchQueue.main.async {
                            //print(jsonResponce[""])
                            if let rates = jsonResponce["rates"] as? [String: Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(String(format: "%.2f", cad))"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(String(format: "%.2f", chf))"
                                }
                                if let gbr = rates["GBP"] as? Double {
                                    self.gbrLabel.text = "GBR: \(String(format: "%.2f", gbr))"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(String(format: "%.2f", jpy))"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(String(format: "%.2f", usd))"
                                }
                                if let tur = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(String(format: "%.2f", tur))"
                                }
                            }
                        }
                        
                    } catch {
                        
                        let nserror = error as NSError
                        fatalError("Error response data \(nserror), \(nserror.userInfo)")
                    }
                }
            }
        }
        task.resume()
    }
    
}

