//
//  EditToDoVC.swift
//  Author's name : Amrik Singh
//  StudentID : 301296257
//
//  Todo List app
//
//  Created by Amrik on 13/11/22.
// Version: 1.1

import UIKit

class EditToDoVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    //MARK: - variables and connections
  var Index = IndexPath()
  var toDoDict = ToDoList()
  var callbackforUpdateTodo:((ToDoList?,IndexPath,Bool) -> Void)?
    @IBOutlet weak var PickerSelectDate: UIDatePicker!
    @IBOutlet weak var ViwPicker: UIView!
    @IBOutlet weak var txtFieldTaskName: UITextField!
    @IBOutlet weak var TxtViewLongDesc: UITextView!
    @IBOutlet weak var SwitchDueDate: UISwitch!
    @IBOutlet weak var SwitchIsCompleted: UISwitch!
    
    @IBOutlet weak var ViwNotes: UIView!
    @IBOutlet weak var ViwDue: UIView!
    @IBOutlet weak var ViwIsComplete: UIView!
    @IBOutlet weak var ViwSave: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var placeholderLabel : UILabel!
    var dateStr = ""
    var iscomplete = Bool()
    var isdue = Bool()
    var isAddNew = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpUIForAddNewTodo(visible: isAddNew)
        
        }
    
    //MARK: - UI Setup
    func setupUI() {
        print(toDoDict)
        TxtViewLongDesc.layer.borderColor = UIColor.gray.cgColor
        TxtViewLongDesc.layer.borderWidth = 0.5
        TxtViewLongDesc.layer.cornerRadius = 5.0
        iscomplete = toDoDict.isComplete ?? false
        isdue = toDoDict.isDueDate ?? false
        dateStr = toDoDict.Date ?? ""
        txtFieldTaskName.text = toDoDict.shorTitle ?? ""
        SwitchDueDate.setOn(toDoDict.isDueDate ?? false, animated: false)
        SwitchIsCompleted.setOn(toDoDict.isComplete ?? false, animated: false)
        TxtViewLongDesc.textColor = UIColor.lightGray
        
        if toDoDict.isComplete ?? false
        {
            ViwPicker.isHidden = true
        }
        else if toDoDict.isDueDate ?? false == false
        {
            ViwPicker.isHidden = true
        }
        
        if toDoDict.longDesc ?? "" == ""
        {
        TxtViewLongDesc.text = "Long Description of the Todo \nNotes can also be included here."
        }
        else
        {
        TxtViewLongDesc.text = toDoDict.longDesc ?? ""
        }
        
        if let strdate = toDoDict.Date, strdate != ""
        {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d,yyyy"
        PickerSelectDate.date = dateFormatter.date(from: strdate) ?? Date()
        }
    }
        //MARK: - setUp View For Add New Todo Item
    func setUpUIForAddNewTodo(visible:Bool)
        {
            ViwNotes.isHidden = visible
            ViwDue.isHidden = visible
            ViwIsComplete.isHidden = visible
            ViwSave.isHidden = visible
            btnDelete.isHidden = visible
        }
    
    //MARK: - Btn Edit Action for Todo List
    @IBAction func BtnEditAct(_ sender: Any) {
        
        toDoDict = ToDoList.init(shorTitle: txtFieldTaskName.text, longDesc: TxtViewLongDesc.text, isComplete: iscomplete, isDueDate:isdue , Date: dateStr)
        print(toDoDict)
        callbackforUpdateTodo?(toDoDict,Index,false)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Btn Delete Action for Todo List
    @IBAction func BtnDeleteAct(_ sender: Any) {
        
        callbackforUpdateTodo?(toDoDict,Index,true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Picker Change Date Act(Picker handler)

    @IBAction func PickerChangeDateAct(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d,yyyy"
        dateStr = dateFormatter.string(from: sender.date)
       
        
    }
    
    //MARK: - Todo Compelte Switch Act
    @IBAction func CompelteSwitchAct(_ sender: UISwitch) {
        if sender.isOn
        {
            ViwPicker.isHidden = true
            SwitchDueDate.setOn(false, animated: true)
            iscomplete = true
            isdue = false
        }
        else{
            iscomplete = false
        }
    }
    
    //MARK: - Set Due date
    @IBAction func DueSwitchAct(_ sender: UISwitch) {
        if sender.isOn
        {
            ViwPicker.isHidden = false
            SwitchIsCompleted.setOn(false, animated: true)
            iscomplete = false
            isdue = true
        }
        else
        {
            ViwPicker.isHidden = true
            isdue = false
        }
        
    }
    
    
    
    //MARK: - Btn Back Action for Todo detais screen
    @IBAction func BtnBackAct(_ sender: Any) {
        callbackforUpdateTodo?(toDoDict,Index,true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITextView Delegates for placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text == "" {

            textView.text = "Long Description of the Todo Notes can also be included here."
            textView.textColor = UIColor.lightGray
        }
    }
    //MARK: - keyboard done button tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       
            textField.resignFirstResponder()
        
       return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
