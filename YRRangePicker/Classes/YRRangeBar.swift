//
//  YRRangeSlider.swift
//  YRRangeSlider
//
//  Created by Yuri on 2020/8/16.
//  Copyright © 2020 Yuri. All rights reserved.
//

import UIKit

public class YRRangeBar: UIView {

    /// 最小间距
    public var minSpacing:CGFloat = 5
    /// 操纵按钮的宽度
    public let targetBtnWidth:CGFloat = 20
    
    /// 更新bar的图片
    public func updateBarImage(left:UIImage,right:UIImage) {
        self.leftBtn.setImage(left, for: .normal)
        self.rightBtn.setImage(right, for: .normal)
    }
    /// 选择区改变了
    public var rangeDidChanged:(()->())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    fileprivate lazy var dotLabel: UILabel = {
        let view = UILabel()
        view.text = "触摸点"
        view.textAlignment = .center
        view.textColor = UIColor.black
        view.backgroundColor = .yellow
        view.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.frame = CGRect.init(x: -100, y: -100, width: 40, height: 40)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        
//        window?.addSubview(dotLabel)
    }
   
    func setupSubviews(){
        
        addSubview(leftBtn)
        addSubview(rightBtn)
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard event?.touches(for: self)?.count == 1 else {
            // 仅支持单指手势
            handleStatus = .ilde
            return
        }
        
        guard let touch = (touches as NSSet).anyObject() as? UITouch else {
            handleStatus = .ilde
            return
        }
        
        let position = touch.location(in: self)
        
        if self.leftBtn.frame.contains(position) {
            print("左侧")
            self.bringSubviewToFront(leftBtn)
            currentHandleBtn = leftBtn
            handleStatus = .left
        }else if rightBtn.frame.contains(position){
            print("右侧")
            self.bringSubviewToFront(rightBtn)
            currentHandleBtn = rightBtn
            handleStatus = .right
        }else{
            print("无效")
            currentHandleBtn = nil
            handleStatus = .ilde
            return
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard event?.touches(for: self)?.count == 1 else {
            // 仅支持单指手势
            return
        }
        
        guard let touch = (touches as NSSet).anyObject() as? UITouch else {
            return
        }
        
        guard let window = self.window else { return }
        
        // 计算基于window的位置偏移
        let previousLocationInWindow = touch.previousLocation(in: self.window)
        let currentLocationInWindow = touch.location(in: self.window)
        
        dotLabel.center = currentLocationInWindow
        
        let touchPointInSelf = window.convert(currentLocationInWindow, to: self)
        
        var targetRect = CGRect.init(x: touchPointInSelf.x - targetBtnWidth/2, y: 0, width: targetBtnWidth, height: self.bounds.size.height)
        
        switch handleStatus {
        case .left:
            if targetRect.origin.x < 0  {
                targetRect.origin.x = 0
            }
            if targetRect.maxX > (rightBtn.frame.origin.x - minSpacing) {
                targetRect.origin.x = rightBtn.frame.origin.x - minSpacing - targetBtnWidth
            }
            leftBtn.frame = targetRect
            break
        case .right:
            if targetRect.maxX > self.bounds.size.width {
                targetRect.origin.x = self.bounds.size.width - targetBtnWidth
            }
            if targetRect.minX < (leftBtn.frame.maxX + minSpacing) {
                targetRect.origin.x = leftBtn.frame.maxX + minSpacing
            }
            rightBtn.frame = targetRect
            break
        default:
            break
        }
        rangeDidChanged?()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        print("layoutSubviews")
        
        if !didSetupLayout  && bounds.size.width > 0{
            didSetupLayout = true
            leftBtn.frame = CGRect.init(x: 0.0, y: 0.0, width: targetBtnWidth, height: self.bounds.size.height)
            rightBtn.frame = CGRect.init(x: self.bounds.size.width-targetBtnWidth, y: 0.0, width: targetBtnWidth, height: self.frame.size.height)
            self.rangeDidChanged?()
        }
        
    }
    
    enum HandleStatus {
        case left
        case right
        case ilde
    }
    enum MoveDirection {
        case left
        case right
        case none
    }
    
    enum Event {
        case touchDoun
        case moving
        case touchUp
    }
    
    /// 左侧操作按钮
    lazy var leftBtn: YRHotAreaButton = {
        let view = YRHotAreaButton.init(type: .custom)
        view.imageView?.contentMode = .scaleAspectFit
        view.setBackgroundImage(UIImage.init(named: "rangeSlider_left"), for: .normal)
        view.setBackgroundImage(UIImage.init(named: "rangeSlider_left_h"), for: .highlighted)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    /// 右侧操纵按钮
    lazy var rightBtn: YRHotAreaButton = {
        let view = YRHotAreaButton.init(type: .custom)
        view.imageView?.contentMode = .scaleAspectFit
        view.setBackgroundImage(UIImage.init(named: "rangeSlider_right"), for: .normal)
        view.setBackgroundImage(UIImage.init(named: "rangeSlider_right_"), for: .highlighted)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    /// 当前捕获的按钮
    fileprivate var currentHandleBtn:UIButton? = nil
    /// 捕获状态
    fileprivate var handleStatus:HandleStatus = .ilde
    fileprivate var moveDirection:MoveDirection = .none
    /// 已经初始化布局
    fileprivate var didSetupLayout:Bool = false
}


