//
//  YRMineButton.swift
//  todayweather
//
//  Created by Yuri on 2019/10/12.
//  Copyright © 2019 Yuri. All rights reserved.
//

import UIKit

public class YRHotAreaButton: UIButton {

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        var rect = self.bounds
        
        var widthDelta:CGFloat = 20
        var heightDelta:CGFloat = 20
        
        if rect.size.width < 44 {
            widthDelta = (rect.size.width - 44 ) * 0.5
        }
        if rect.size.height < 44 {
            heightDelta = (rect.size.height - 44 ) * 0.5
        }
        rect = rect.insetBy(dx: widthDelta, dy: heightDelta)
        return rect.contains(point)
    }
    

}
