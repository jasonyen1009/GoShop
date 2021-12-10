//
//  ProductViewController.swift
//  GoShop
//
//  Created by Hong Cheng Yen on 2021/11/4.
//

import UIKit

class ProductViewController: UIViewController {
    
    
    @IBOutlet var favoriteButton: [UIButton]!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet var fruitsvegetableTextField: [UITextField]!
    @IBOutlet var beverageTextField: [UITextField]!
    @IBOutlet var meatfishTextField: [UITextField]!
    @IBOutlet var fruitsvegetableStepper: [UIStepper]!
    @IBOutlet var beverageStepper: [UIStepper]!
    @IBOutlet var meatfishStepper: [UIStepper]!
    
    var buttonn:[String] = []
//        didSet {
//            let name = Notification.Name("Keytest")
//            NotificationCenter.default.post(name: name, object: nil, userInfo: ["text": buttonn])
//
//        }
    
    var budget: Double!
    
    
    init?(coder: NSCoder, budget: Double) {
        self.budget = budget
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetLabel.text = String(budget)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    //收鍵盤
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
        //同步textfield值
        for i in 0...3 {
            upperlimit(number: i)
        }
        updateUI()
    }
    
    //fruits&vegetableStepper-Stepper同步TextField
    @IBAction func fruitsvegetableStepper(_ sender: UIStepper) {
        switch sender {
        case fruitsvegetableStepper[0]:
            fruitsvegetableTextField[0].text = String(Int(sender.value))
        case fruitsvegetableStepper[1]:
            fruitsvegetableTextField[1].text = String(Int(sender.value))
        case fruitsvegetableStepper[2]:
            fruitsvegetableTextField[2].text = String(Int(sender.value))
        default:
            fruitsvegetableTextField[3].text = String(Int(sender.value))
        }
        updateUI()
//        let value1 = 4.99 * fruitsvegetableStepper[0].value
//        let value2 = 4.99 * fruitsvegetableStepper[1].value
//        print(budget - value1)
//        budgetLabel.text = String(budget - value1 - value2)
//        updateUI()
    }
    
    //beverage-Stepper同步TextField
    @IBAction func beverageStepper(_ sender: UIStepper) {
        switch sender {
        case beverageStepper[0]:
            beverageTextField[0].text = String(Int(sender.value))
        case beverageStepper[1]:
            beverageTextField[1].text = String(Int(sender.value))
        case beverageStepper[2]:
            beverageTextField[2].text = String(Int(sender.value))
        default:
            beverageTextField[3].text = String(Int(sender.value))
        }
        updateUI()
    }
    //meat&fish-Stepper同步TextField
    @IBAction func meatfishStepper(_ sender: UIStepper) {
        switch sender{
        case meatfishStepper[0]:
            meatfishTextField[0].text = String(Int(sender.value))
        case meatfishStepper[1]:
            meatfishTextField[1].text = String(Int(sender.value))
        case meatfishStepper[2]:
            meatfishTextField[2].text = String(Int(sender.value))
        default:
            meatfishTextField[3].text = String(Int(sender.value))
        }
        updateUI()
    }
    
    //數值限制&Stepper同步textfield
    func upperlimit(number: Int) {
        //數值超過999時，textfield設定為999
        if Double(fruitsvegetableTextField[number].text!) ?? 0 > 999 {
            fruitsvegetableTextField[number].text = "999"
        }
        if Double(beverageTextField[number].text!) ?? 0 > 999 {
            beverageTextField[number].text = "999"
        }
        if Double(meatfishTextField[number].text!) ?? 0 > 999 {
            meatfishTextField[number].text = "999"
        }
        fruitsvegetableStepper[number].value = Double(fruitsvegetableTextField[number].text!) ?? 0
        beverageStepper[number].value = Double(beverageTextField[number].text!) ?? 0
        meatfishStepper[number].value = Double(meatfishTextField[number].text!) ?? 0
//        updateUI()
    
    }
    //畫面更新
    func updateUI() {
        let value1 = 4.99 * fruitsvegetableStepper[0].value
        let value2 = 4.99 * fruitsvegetableStepper[1].value
        let value3 = 1.75 * fruitsvegetableStepper[2].value
        let value4 = 4.99 * fruitsvegetableStepper[3].value
        let value5 = 1.99 * beverageStepper[0].value
        let value6 = 1.50 * beverageStepper[1].value
        let value7 = 15.99 * beverageStepper[2].value
        let value8 = 15.50 * beverageStepper[3].value
        let value9 = 10.54 * meatfishStepper[0].value
        let value10 = 3.01 * meatfishStepper[1].value
        let value11 = 11.2 * meatfishStepper[2].value
        let value12 = 12.75 * meatfishStepper[3].value

        budgetLabel.text = String(format: "%.2f", budget - value1 - value2 - value3 - value4 - value5 - value6 - value7 - value8 - value9 - value10 - value11 - value12)
        
        //預算小於０時觸發警示窗口，並且清除所有所選商品
        if Double(budgetLabel.text!)! < 0 {
            let alertcontroller = UIAlertController(title: "💸💸💸", message: "Sorry you don't have enough budget. Do you what to change your budget?", preferredStyle: .alert)

            alertcontroller.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ _ in
                print("get yes")
                
                //新增第二視窗（輸入新的預算）
                let alertcontroller1 = UIAlertController(title: "Change  budget", message: "", preferredStyle: .alert)
                alertcontroller1.addTextField { textfield in
                    textfield.placeholder = "budget"
                    textfield.keyboardType = .numberPad
                }
                alertcontroller1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alertcontroller1.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned alertcontroller1] _ in
                    let value = alertcontroller1.textFields?[0].text
                    self.budget = Double(value!) ?? self.budget
                    self.budgetLabel.text = String(self.budget)
                }))
                self.present(alertcontroller1, animated: true, completion: nil)
            }))
            alertcontroller.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            }))
            present(alertcontroller, animated: true, completion: nil)
            clear(UIButton.self)
            
        }
    }
    
    //更改預算視窗
    @IBAction func changebudget(_ sender: Any) {
        let alertcontroller = UIAlertController(title: "Change budget", message: "", preferredStyle: .alert)
        alertcontroller.addTextField { textfield in
            textfield.placeholder = "budget"
            textfield.keyboardType = .numberPad
        }
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned alertcontroller] _ in
            let value = alertcontroller.textFields?[0].text
            //如果沒有值，回傳原本budget
            self.budget = Double(value!) ?? self.budget
            self.budgetLabel.text = String(self.budget)
        }))
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertcontroller, animated: true, completion: nil)
    }
    
    
    
    //清除所有所選的商品
    @IBAction func clear(_ sender: Any) {
        for i in 0...3 {
            fruitsvegetableTextField[i].text = "0"
            beverageTextField[i].text = "0"
            meatfishTextField[i].text = "0"
            //數值限制&Stepper同步textfield
            upperlimit(number: i)
        }
        //預算回歸初始值
        budgetLabel.text = String(format: "%.2f", budget)
    }

    //傳資料測試
    @IBAction func buttontest(_ sender: UIButton) {
        switch sender {
        case favoriteButton[0]:
            sender.isSelected.toggle()
//            if sender.isSelected == true {
//                buttonn.append("button1")
//            }else {
//                buttonn.removeAll {$0 == "button1"}
//            }
        case favoriteButton[1]:
            sender.isSelected.toggle()
//            if sender.isSelected == true {
//                buttonn.append("button2")
//            }else {
//                buttonn.removeAll {$0 == "button2"}
//            }
        case favoriteButton[2]:
            sender.isSelected.toggle()
        case favoriteButton[3]:
            sender.isSelected.toggle()
        case favoriteButton[4]:
            sender.isSelected.toggle()
        case favoriteButton[5]:
            sender.isSelected.toggle()
        case favoriteButton[6]:
            sender.isSelected.toggle()
        case favoriteButton[7]:
            sender.isSelected.toggle()
        case favoriteButton[8]:
            sender.isSelected.toggle()
        case favoriteButton[9]:
            sender.isSelected.toggle()
        case favoriteButton[10]:
            sender.isSelected.toggle()
        case favoriteButton[11]:
            sender.isSelected.toggle()
        
        default:
            break
        }
        print(buttonn)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
