//
//  HistoryViewController.swift
//  UnitConverter
//
//  Created by Vithushan Gnanaraj on 2021-03-11.
//

import UIKit

class HistoryViewController: UIViewController {
      
    var history : [String] = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource=self
        defaults.set("weight", forKey: "historySeg")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initHistoryInfo()
    }
    
    
        func initHistoryInfo() {
            if(defaults.string(forKey: "historySeg") == "weight"){
                loadDefaultsData("weightHistory")
//                return
            }else if(defaults.string(forKey: "historySeg") == "temperature"){
                loadDefaultsData("temperatureHistory")
            }else if(defaults.string(forKey: "historySeg") == "volume"){
                loadDefaultsData("volumeHistory")
            }else if(defaults.string(forKey: "historySeg") == "length"){
                loadDefaultsData("lengthHistory")
            }else if(defaults.string(forKey: "historySeg") == "speed"){
                loadDefaultsData("speedHistory")
            }
            
        }
    
        //loads the appropriate UserDefaults storage object according to the view name (key provided to created the storage object)
        func loadDefaultsData(_ historyKey :String) {
//            let defaults = UserDefaults.standard
            history = defaults.object(forKey: historyKey) as? [String] ?? [String]()
            self.tableView.reloadData()
        }
    
    @IBAction func historySegmentedChange(_ sender: UISegmentedControl) {
    
        if(sender.selectedSegmentIndex == 0){
            defaults.set("weight", forKey: "historySeg")
        }
        else if(sender.selectedSegmentIndex == 1){
            defaults.set("temperature", forKey: "historySeg")
        }
        else if(sender.selectedSegmentIndex == 2){
            defaults.set("volume", forKey: "historySeg")
        }
        else if(sender.selectedSegmentIndex == 3){
            defaults.set("length", forKey: "historySeg")
        }
        else if(sender.selectedSegmentIndex == 4){
            defaults.set("speed", forKey: "historySeg")
        }
        
        initHistoryInfo()
    }
 
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //self.tableView.reloadData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableHistoryCell")!
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = history[indexPath.row]
        return cell
       
    }
}
