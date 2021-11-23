//
//  BudgetViewController.swift
//  GoShop
//
//  Created by Hong Cheng Yen on 2021/10/25.
//

import UIKit

class BudgetViewController: UIViewController {
    
    @IBOutlet weak var EnterLabel: UILabel!
    @IBOutlet weak var BudgetTextField: UITextField!
    @IBOutlet weak var NextpageButton: UIButton!
    @IBOutlet weak var WarningSign: UILabel!
    @IBOutlet weak var LabelConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //創建一個模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        //創建一個乘載模糊效果的視圖
        let blurView = UIVisualEffectView(effect: blurEffect)
        //設定模糊視圖的大小（全頻）
            blurView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        //添加模糊視圖到頁面 view 上（模糊視圖下方都會有模糊效果）
        WarningSign.isHidden = true
        self.view.addSubview(blurView)
        self.view.addSubview(NextpageButton)
        self.view.addSubview(EnterLabel)
        self.view.addSubview(BudgetTextField)
        self.view.addSubview(WarningSign)


        // Do any additional setup after loading the view.
    }
    

    @IBSegueAction func nextpage(_ coder: NSCoder) -> ProductViewController? {
        let controller = ProductViewController(coder: coder, budget: Double(BudgetTextField.text!) ?? 0)
        return controller
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if BudgetTextField.text?.isEmpty == false,
           Double(BudgetTextField.text!) ?? 0 > 0 {
            return true
        }else {
            //加入提醒字幕
            WarningSign.isHidden = false
            WarningSign.text = "Please enter your budget"
            
            //加入動畫
            let animator = UIViewPropertyAnimator(duration: 2, dampingRatio: 0.1) {
                self.LabelConstraint.constant = 55
                self.view.layoutIfNeeded()
            }
            animator.startAnimation()
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0) {
                self.LabelConstraint.constant = 25
                self.view.layoutIfNeeded()
            }
            return false
        }
    }
    
    //收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
