//
//  BNRDrawView.swift
//  TouchTracker_swift
//
//  Created by 毛泉 on 2016/10/20.
//  Copyright © 2016年 MaoQuan. All rights reserved.
//

import UIKit

class BNRDrawView: UIView {
    var linesInProgress :[AnyHashable:Any] = [:]
    var finishedLines : [Any] = []
    
    
    override init(frame: CGRect){
        super.init(frame:frame);
        self.linesInProgress = Dictionary.init();
        self.finishedLines = Array.init();
        self.backgroundColor = UIColor.gray
        self.isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: self);
            let line  = BNRLine();
            line.begin = location
            line.end = location
            
            let key = NSValue(nonretainedObject: t);
            self.linesInProgress[key] = line
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let key = NSValue(nonretainedObject: t);
            let line : BNRLine = self.linesInProgress[key] as! BNRLine;
            
            line.end = t.location(in: self);
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let key = NSValue(nonretainedObject: t);
            let line = self.linesInProgress[key];
            self.finishedLines.append(line);
            self.linesInProgress.removeValue(forKey: key);
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let key = NSValue(nonretainedObject: t)
            self.linesInProgress.removeValue(forKey: key)
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        //self.backgroundColor = UIColor.black
        for line in self.finishedLines{
            strokeLine(line: line as! BNRLine,color:UIColor.black)
        }
        for key in self.linesInProgress{
            strokeLine(line: key.value as! BNRLine,color:UIColor.red)
        }
    }

    
    func strokeLine (line:BNRLine,color:UIColor){
        let strokeColor = color
        let bp : UIBezierPath! = UIBezierPath()
        bp.lineWidth = 10
        bp.lineCapStyle = .round
        bp.move(to: line.begin)
        bp.addLine(to: line.end)
        strokeColor.setStroke()
        bp.stroke()
    }
    
    
}
