//
//  ViewController.swift
//  DataBase Controller
//
//  Created by Appinventiv-Mac on 08/03/18.
//  Copyright © 2018 Appinventiv-Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var mobileOutlet: UITextField!
    
    let user = DBController(nameOfEntity: "Person") //intializing the DBController
    var personData = [Person]()
    var currentIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubView()
        nameOutlet.delegate=self
        mobileOutlet.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpSubView() {
        self.personTableView.dataSource = self
        self.personTableView.delegate = self
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        user.saveData(namePassed:self.nameOutlet.text!,mobilePassed:self.mobileOutlet.text!)
        self.personTableView.reloadData()
    }
    
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        personData=user.fetchData() as! [Person]
        if personData.count != 0 {
        self.personTableView.reloadData()
        }
        else {
            Alerts.displayAlertMessage(messageToDisplay: "No Data")
        }
    }
    
    @IBAction func dropButtonTapped(_ sender: UIButton) {
        if personData.count != 0 {
        user.dropData()
        personData.removeAll()
        self.personTableView.reloadData()
        }
        else {
            Alerts.displayAlertMessage(messageToDisplay: "No Data to drop")
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        if((personData.count != 0)&&(currentIndex != nil)) {
            personData=user.deleteData(index: currentIndex) as! [Person]
            self.personTableView.reloadData()
        }
        else {
                Alerts.displayAlertMessage(messageToDisplay: "No Data Selected for deletion")
        }
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        if((Validations.validate_mobile(mobile: self.mobileOutlet.text!))&&(Validations.validate_name(name: self.nameOutlet.text!))) {
            personData=user.updateData(index: currentIndex,mobile:self.mobileOutlet.text!) as! [Person]
            self.personTableView.reloadData()
        }
        else {
               Alerts.displayAlertMessage(messageToDisplay: "Enter Valid Data")
        }
    }
}

//Table View Methods
extension ViewController:UITableViewDataSource,UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        let user = self.personData[indexPath.row]
        cell.textLabel?.text = "Name: \((user.name)!)           Mobile No.: \((user.mobile)!)"
        return cell

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
        headerView.backgroundColor = UIColor.lightGray
        
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 1, y: 5, width: 276, height: 30))
        labelView.text = "Core Data:"
        labelView.font = UIFont.init(name: "Avenir Next", size: 17)
        labelView.textAlignment = .left
        
        headerView.addSubview(labelView)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex=indexPath.row //storing index of selected row
    }
    
}

//TextField Methods
extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameOutlet:
            nameOutlet.resignFirstResponder()
            mobileOutlet.becomeFirstResponder()
        case mobileOutlet:
            mobileOutlet.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameOutlet:
            if !(nameOutlet.text!.isEmpty) {
                if (Validations.validate_name(name: nameOutlet.text!)==false) {
                    Alerts.displayAlertMessage(messageToDisplay: "Enter a valid name")
                }
            }
        case mobileOutlet:
            if !(mobileOutlet.text!.isEmpty) {
                if (Validations.validate_mobile(mobile: mobileOutlet.text!)==false) {
                Alerts.displayAlertMessage(messageToDisplay: "Enter a valid mobile number")
                }
            }
        default:
            print("No error in Data.")
        }
    }
    
}


