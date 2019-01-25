//
//  SplashViewController.swift
//  CanLo-300941213-SlotMachineIos
//
//  Created by Đậu Thư on 2019-01-19.
//  Copyright © 2019 Can Lo. All rights reserved.
//

import UIKit
extension String {
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var showResult: UILabel!
    @IBOutlet weak var moneyWon: UILabel!
    @IBOutlet weak var ownMoney: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var imageArray:[UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imageArray = ["🍎".emojiToImage()!,
                      "😍".emojiToImage()!,
                      "🐮".emojiToImage()!,
                      "🐼".emojiToImage()!,
                      "🐔".emojiToImage()!,
                      "🎅".emojiToImage()!]
        
        showResult.text = ""
        moneyWon.text = "0"
        ownMoney.text = "6000"
        
        arc4random_stir()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        var winnedMoney = Int(moneyWon.text!)!
        var ownnedMoney = Int(ownMoney.text!)!
        if ownnedMoney>0{
        for i in 0..<5{
            let newValue = Int(arc4random_uniform(UInt32(imageArray.count)))
            if newValue == lastVal{
            numInRow += 1
        }else {
            numInRow = 1
        }
        lastVal = newValue
        
            pickerView.selectRow(newValue, inComponent: i, animated: true)
            pickerView.reloadComponent(i)
            ownnedMoney = ownnedMoney - 100
            ownMoney.text = String(ownnedMoney)
            if numInRow >= 3{
                winnedMoney = winnedMoney + 1000
                ownnedMoney = ownnedMoney + 1000
                moneyWon.text = String(winnedMoney)
                ownMoney.text = String(ownnedMoney)
                win = true
            }
    }
        showResult.text = win ? "WooHoo You Won!!!!" : ""
        if ownnedMoney == 0{
            showResult.text = "Loser Hahaha"
        }
    }
    }
    // function which returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return	5
    }
    
    
    // function which returns the number of rows in each component..
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageArray.count
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = imageArray[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    @IBAction func PlayAgain(_ sender: UIButton) {
        
        showResult.text = ""
        moneyWon.text = "0"
        ownMoney.text = "6000"
        
        arc4random_stir()
        pickerView.delegate = self
        
    }
    
    

    


}

