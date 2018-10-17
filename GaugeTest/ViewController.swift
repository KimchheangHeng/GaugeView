//
//  ViewController.swift
//  GaugeTest
//
//  Created by Kimchheang on 10/16/18.
//  Copyright © 2018 Kimchheang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var center: CGPoint!
    let startAngle = -CGFloat(Double.pi * 4.0 / 3.0)
    let endAngle = -CGFloat(Double.pi * 5.0 / 3.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupView()
    }

    func setupView() {
        center = CGPoint(x: view.center.x, y: view.center.y - 100)
        
        addTickLayer(radius: 105, color: UIColor.blue)
        addTickTitles(radius: 105, color: UIColor.blue)
        
        
        addSubLayer(radius: 120, color: UIColor.blue, title: "HOME")
        addSubLayer(radius: 140, color: UIColor.blue, title: "WORK")
        addSubLayer(radius: 160, color: UIColor.blue, title: "OUTDOOR")
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "profile")
        imageView.center = center
        view.addSubview(imageView)
    }
    
    func addSubLayer(radius: CGFloat, color: UIColor, title: String) {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 12.0
        backgroundLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        backgroundLayer.path = UIBezierPath(arcCenter: center, radius: radius,
                                            startAngle: startAngle, endAngle: endAngle,
                                            clockwise: true).cgPath
        view.layer.addSublayer(backgroundLayer)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (radius * 1.04720), height: 40))
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.minimumScaleFactor = 0.2
        titleLabel.textAlignment = .center
        titleLabel.center = CGPoint(x: center.x, y: center.y + radius - 10)
        view.addSubview(titleLabel)
        
        
        let lastIndex = 18
        for i in 0..<lastIndex {
            let lineLayer = CAShapeLayer()
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.lineWidth = 12.0
            lineLayer.strokeColor = UIColor(red: CGFloat.random(in: 0..<1.0), green: CGFloat.random(in: 0..<1.0), blue: CGFloat.random(in: 0..<1.0), alpha: 1.0).cgColor
            lineLayer.lineJoin = CAShapeLayerLineJoin.round
            lineLayer.path = UIBezierPath(arcCenter: center, radius: radius,
                                          startAngle: startAngle + CGFloat(0.2181662) * CGFloat(i) + (0.0174533 / 4),
                                          endAngle: startAngle + CGFloat(0.2181662) * CGFloat(i + 1) - (0.0174533 / 4),
                                          clockwise: true).cgPath
            
            // Add 2 more layers to display the rounded cap
            let headTailLayer = CAShapeLayer()
            headTailLayer.fillColor = UIColor.clear.cgColor
            headTailLayer.lineWidth = 12.0
            headTailLayer.strokeColor = lineLayer.strokeColor
            headTailLayer.lineCap = .round
            
            if i == 0 {
                headTailLayer.path = UIBezierPath(arcCenter: center, radius: radius,
                                                  startAngle: startAngle,
                                                  endAngle: startAngle + (0.0174533 / 2),
                                                  clockwise: true).cgPath
                view.layer.addSublayer(headTailLayer)
            }
            
            if i == lastIndex - 1 {
                headTailLayer.path = UIBezierPath(arcCenter: center, radius: radius,
                                                  startAngle: startAngle + CGFloat(0.2181662) * CGFloat(i+1) - (0.0174533 / 2),
                                                  endAngle: startAngle + CGFloat(0.2181662) * CGFloat(i+1),
                                                  clockwise: true).cgPath
                view.layer.addSublayer(headTailLayer)
            }
            view.layer.addSublayer(lineLayer)
        }
    }
    
    func addTickLayer(radius: CGFloat, color: UIColor) {
        let tickLayer = CAShapeLayer()
        tickLayer.fillColor = UIColor.clear.cgColor
        tickLayer.lineWidth = 8.0
        tickLayer.strokeColor = color.cgColor
        tickLayer.path = UIBezierPath(arcCenter: center, radius: radius,
                                      startAngle: startAngle, endAngle: endAngle + (0.0174533 / 2),
                                      clockwise: true).cgPath
        
        tickLayer.lineDashPattern = [ (radius * (0.0174533 / 2)), (radius * 0.2181662) - (radius * (0.0174533 / 2))] as [NSNumber]
        view.layer.addSublayer(tickLayer)
    }
    
    func addTickTitles(radius: CGFloat, color: UIColor) {
        let tickTitles = ["0", "2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24"]
        for (index, tickTitle) in tickTitles.enumerated() {
            let angle = startAngle + CGFloat(0.2181662 * 2.0) * CGFloat(index) + (0.0174533 / 4)
            let labelCenterX = round(cos(angle) * (radius - 16)) + center.x
            let labelCenterY = round(sin(angle) * (radius - 16)) + center.y
            
            let tickLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 32, height: 16))
            tickLabel.font = UIFont.systemFont(ofSize: 14)
            tickLabel.text = tickTitle
            tickLabel.textColor = color
            tickLabel.minimumScaleFactor = 0.2
            tickLabel.textAlignment = .center
            tickLabel.center = CGPoint(x: labelCenterX, y: labelCenterY)
            view.addSubview(tickLabel)
        }
    }
}
