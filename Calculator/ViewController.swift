//
//  ViewController.swift
//  Calculator
//
//  Created by 김원기 on 2022/08/09.
//

import UIKit

//열거형 선언
enum Operation {
    case Plus
    case Minus
    case Divide
    case Multiply
    case unknown //아무런 연산자가 없는 케이스
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var OutputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 계산기에 상태값을 가지고있는 프로퍼티 선언
    var displayNumber = "" //버튼이 눌릴때 마다 outputlabel에 표시되는 숫자
    var firstOperand = "" //이전 계산값을 저장하는 프로퍼티
    var secondeOperand = "" //새롭게 입력되는 값을 저장하는 프로퍼티
    var result = "" //결과값을 저장하는 프로퍼티
    var currentOperation: Operation = .unknown //현재 계산기에 어떤 연산자가 입력되었는지 알 수 있게 연산자의 값을 저장하는 프로퍼티
    
    
    @IBAction func NumberButton(_ sender: UIButton) {
        
        guard let NumberValue = sender.titleLabel?.text else { return }
        if self.displayNumber.count < 9 {
            self.displayNumber += NumberValue
            self.OutputLabel.text = self.displayNumber
        }
    }
    
    
    @IBAction func ClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondeOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.OutputLabel.text = "0"
    }
    
    @IBAction func DotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8 , !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.OutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func DivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func MultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func MinusButton(_ sender: UIButton) {
        self.operation(.Minus)
    }
    
    @IBAction func PlusButton(_ sender: UIButton) {
        self.operation(.Plus)
    }
    
    @IBAction func EqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    //계산을 담당하는 함수 정의
    func operation(_ operation: Operation) {
        if self.currentOperation != .unknown { //언노운이 아니면 첫번째 두번째 피연산자 간의 연산을 구현하는 로직
            
            if !self.displayNumber.isEmpty{ // 디스플레이 넘버가 비어있지 않으면
                self.secondeOperand = self.displayNumber // 두번째 값 입력
                self.displayNumber = "" // 결과값 표시 전 초기화
                
                //연산위해 더블형으로 변경
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondeOperand) else {return}
                
                
                switch self.currentOperation{
                case .Plus:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Minus:
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                    
                default:
                    break
                }
                
                //소수점을 지우는 코드
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                //연산한 값을 다시 사용할 수 있도록 첫번째 피연산자 자리에 입력할 수 있도록 하는 코드
                self.firstOperand = self.result
                self.OutputLabel.text = self.result
            }
            self.currentOperation = operation
            
        } else { // 계산기가 초기화된 상태에서 첫번째 피연산자와 연산자를 선택한 상황
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

