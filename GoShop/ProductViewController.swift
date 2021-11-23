//
//  ProductViewController.swift
//  GoShop
//
//  Created by Hong Cheng Yen on 2021/11/4.
//

import UIKit

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet var fruitsvegetableTextField: [UITextField]!
    @IBOutlet var beverageTextField: [UITextField]!
    @IBOutlet var meatfishTextField: [UITextField]!
    @IBOutlet var fruitsvegetableStepper: [UIStepper]!
    @IBOutlet var beverageStepper: [UIStepper]!
    @IBOutlet var meatfishStepper: [UIStepper]!
    
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
            let alertcontroller = UIAlertController(title: "💸💸💸", message: "Sorry you don't have enough budget", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertcontroller, animated: true, completion: nil)
            
            clear(UIButton.self)
        }
        
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
