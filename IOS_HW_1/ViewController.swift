//
//  ViewController.swift
//  IOS_HW_1
//
//  Created by Андрей Гусев on 20/09/2022.
//

import UIKit

extension UIColor {

    static func getRandomHex() -> String {
        let num = Int.random(in: 0...16777216)

        var color = String(format:"%02X", num)

        while (color.count < 6) {
            color += "0"
        }

        let result = String(color.reversed())

        print("Generated color is \(result)")

        return result
    }
    
    static func hexToRGB(hexColor: String = getRandomHex()) -> UIColor {
        print(hexColor)

        var colors = [Int](0...2)

        let letters: [Character: String] = [
            "0": "0000",
            "1": "0001",
            "2": "0010",
            "3": "0011",
            "4": "0100",
            "5": "0101",
            "6": "0110",
            "7": "0111",
            "8": "1000",
            "9": "1001",
            "A": "1010",
            "B": "1011",
            "C": "1100",
            "D": "1101",
            "E": "1110",
            "F": "1111"
        ]

        var binaryNum: String = ""

        for el in hexColor {
            if let letter = letters[el] {
                binaryNum += letter
            }
        }

        var j = 0.0
        var ch = 0
        var result = 0.0

        for el in binaryNum {
            if (el == "1") {
                print(pow(2, j))
                result += pow(2, j)
            }

            if (j != 0 && Int(j) % 7 == 0) {
                colors[ch] = Int(result)
                j = -1
                ch += 1
                print("Maked number is \(result)")
                print()
                result = 0
            }
            j += 1
        }
//        for el in colors {
//            print(el)
//        }
        //print()
        let ans = UIColor(
            red: Double(colors[0]) / 255,
            green: Double(colors[1]) / 255,
            blue: Double(colors[2]) / 255,
            alpha: 1
        )

        print(ans)
        return ans
    }
    
}

extension UIView{
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        let randNum = CGFloat.random(in: 10...20)
        animation.values = [-randNum, randNum, -randNum, randNum, -randNum / 2, randNum / 2, -randNum / 4, randNum / 4, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateColors()
        // Do any additional setup after loading the view.
    }

    func updateColors(duration: TimeInterval = 0, sender: Any = NSNull()) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        var set = Set<UIColor>()

        while set.count < views.count {
            set.insert(UIColor.hexToRGB())
//            set.insert(
//                UIColor(
//                    red: .random(in: 0...1),
//                    green: .random(in: 0...1),
//                    blue: .random(in: 0...1),
//                    alpha: 1
//                )
//            )
        }
//        for el in set {
//            print(el)
//        }
        for el in views {
            UIView.animate(
                withDuration: 1,
                animations: {
                    if (.random(in: 1...3) == 1) {
                        el.shake()
                    }

                    el.backgroundColor = set.popFirst()
                    el.layer.cornerRadius = .random(in: 0...25)
                },
                completion: { _ in
                    button?.isEnabled = true
                }
            )
        }
    }
    
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        self.updateColors(duration: 0.2, sender: sender)
    }
    
}
