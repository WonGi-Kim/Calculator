//
//  RoundButton.swift
//  Calculator
//
//  Created by 김원기 on 2022/08/09.
//

import UIKit

@IBDesignable

class RoundButton: UIButton {
    //IBInsepctable과 IBDesignable을 이용하여 프로퍼티에 접근하여 corner radius값을 변경
    
    @IBInspectable var isRound: Bool = false {
        didSet{
            if isRound {
                //isRound 가 true 이면 버튼으 높이를 2로 나눈값이 정사각형 버튼이 원이 되고 정사각형이 아닌 버튼은 둥글어진다
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
