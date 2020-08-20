//
//  YRRangePicker.swift
//  YRRangeSlider
//
//  Created by Yuri on 2020/8/20.
//  Copyright © 2020 Yuri. All rights reserved.
//

import UIKit

public class YRRangePicker: UIView {

    /// 更新了选择区
    public var didUpdateRange:((_ min:CGFloat,_ max:CGFloat)->())?
    
    public let contentView = UIView()
    
    lazy var corverView: UIView = {
        let view = UIView()
        view.layer.addSublayer(self.shapLayer)
        return view
    }()
    
    lazy var shapLayer: CAShapeLayer = {
        let shapLayer = CAShapeLayer.init()
        shapLayer.fillRule = .evenOdd
        shapLayer.fillColor = UIColor.init(white: 0, alpha: 0.5).cgColor
        return shapLayer
    }()
    
    public lazy var rangeBar: YRRangeBar = {
        let view = YRRangeBar()
        view.rangeDidChanged = { [weak self] in
            self?.updateChosedRange()
        }
        return view
    }()
    
    public var pickType: PickType {
        didSet {
            self.updateChosedRange()
        }
    }
    
    public init(pickType: PickType,frame:CGRect) {
        self.pickType = pickType
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        self.pickType = .center
        super.init(coder: coder)
        setupSubviews()
    }
    
    fileprivate func setupSubviews(){
        NotificationCenter.default.addObserver(self, selector: #selector(appDidActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        addSubview(contentView)
        addSubview(corverView)
        addSubview(rangeBar)
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let contentWidth = bounds.size.width-rangeBar.targetBtnWidth*2
        contentView.frame = CGRect.init(x: rangeBar.targetBtnWidth, y: 0, width: contentWidth, height: bounds.size.height)
        corverView.frame = CGRect.init(x: rangeBar.targetBtnWidth, y: 0, width: contentWidth, height: bounds.size.height)
        rangeBar.frame = CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        rangeBar.setNeedsLayout()
        shapLayer.frame = corverView.bounds
        
        updateChosedRange()
        
    }
}

extension YRRangePicker {
    
    fileprivate func updateChosedRange(){
        updateShapLayerPath()
    }
    
    /// 更新shapLayer的path
    fileprivate func updateShapLayerPath(){
        
        let leftFrameInCorverView = rangeBar.convert(rangeBar.leftBtn.frame, to: corverView)
        let rightFrameInCorverView = rangeBar.convert(rangeBar.rightBtn.frame, to: corverView)
        
        let x = leftFrameInCorverView.maxX
        let width = rightFrameInCorverView.minX - leftFrameInCorverView.maxX
        
        
        if self.pickType == .center {
            let bpath = UIBezierPath.init(rect: corverView.bounds)
            let showPath = UIBezierPath.init(rect: CGRect.init(x: x , y: 0, width: width , height: corverView.bounds.size.height)).reversing()
            bpath.append(showPath)
            shapLayer.path = bpath.cgPath
        }else{
            let bpath = UIBezierPath.init(rect: CGRect.init(x: x, y: 0, width: width, height: corverView.bounds.size.height))
            shapLayer.path = bpath.reversing().cgPath
        }
    
        let leftPercent = leftFrameInCorverView.maxX / corverView.bounds.size.width
        let rightPercent = rightFrameInCorverView.minX / corverView.bounds.size.width
        didUpdateRange?(leftPercent,rightPercent)
    }
}

extension YRRangePicker {
    /// 选择类型
    public enum PickType {
        /// 中间
        case center
        // 外侧
        case outside
    }
    
    @objc func appDidActive(){
        updateChosedRange()
    }
}
