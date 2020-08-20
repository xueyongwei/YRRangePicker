//
//  ViewController.swift
//  YRRangePicker
//
//  Created by Yuri on 08/20/2020.
//  Copyright (c) 2020 Yuri. All rights reserved.
//

import UIKit
import YRRangePicker
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        picker.rangeBar.updateBarImage(left: <#T##UIImage#>, right: <#T##UIImage#>)
        picker.didUpdateRange = { min,max in
            print("min:\(min) , max:\(max)")
        }
        view.addSubview(picker)
        
        changeBtn.frame = CGRect.init(x: 50, y: 200, width: 100, height: 50)
        view.addSubview(changeBtn)
    }
    
    lazy var picker: YRRangePicker = {
        let picker = YRRangePicker.init(pickType: .outside, frame: CGRect.init(x: 50, y: 100, width: 300, height: 40))
        picker.contentView.backgroundColor = UIColor.yellow
        return picker
    }()
    
    lazy var changeBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("改变picker类型", for: .normal)
        view.setImage(nil, for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.addTarget(nil, action: #selector(onChangeClick), for: .touchUpInside)
        return view
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onChangeClick(){
        if self.picker.pickType == .center {
            self.picker.pickType = .outside
        }else{
            self.picker.pickType = .center
        }
    }
}

