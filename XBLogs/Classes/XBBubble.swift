//
//  XBBubble.swift
//  Created on 2023/8/14
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 LMKJ. All rights reserved.
//  @author 刘小彬(liuxiaomike@gmail.com)   
//

import UIKit

/// MARK - Bubble
public final class XBBubble: UIView {

    /// 宽高
    private var customHeight: CGFloat = 50
    private var customWidth: CGFloat = 50
    
    /// 标签
    private lazy var titleLabel: UILabel = {
        $0.text = "日志"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.white
        $0.isUserInteractionEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 100, width: customWidth, height: customHeight))
        configView()
        configLocation()
    }
    
    /// 配置视图
    private func configView() {
        
        backgroundColor = .black
        layer.cornerRadius = customHeight/2
        
        //添加手势
        let selector = #selector(XBBubble.panDidFire(panner:))
        let panGesture = UIPanGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(panGesture)
        
        addSubview(titleLabel)
    }
    
    /// 配置位置
    private func configLocation() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
    /// 拖动手势
    /// - Parameter panner: UIPanGestureRecognizer
    @objc func panDidFire(panner: UIPanGestureRecognizer) {
        
        if panner.state == .began {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        }
        
        let offset = panner.translation(in: self.superview)
        panner.setTranslation(CGPoint.zero, in: self.superview)
        var center = self.center
        center.x += offset.x
        center.y += offset.y
        self.center = center
        
        if panner.state == .ended || panner.state == .cancelled {
            
            var frameInset: UIEdgeInsets
            
            if #available(iOS 11.0, *) {
                frameInset = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
            } else {
                frameInset = UIDevice.current.orientation.isPortrait ? UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) : .zero
            }
            
            let location = panner.location(in: self.superview)
            let velocity = panner.velocity(in: self.superview)
            
            var finalX: Double = Double(customWidth/8*4.25)
            var finalY: Double = Double(location.y)
            
            if location.x > UIScreen.main.bounds.size.width / 2 {
                finalX = Double(UIScreen.main.bounds.size.width) - Double(customWidth/8*4.25)
            }
            
            self.changeSideDisplay()
            
            let horizentalVelocity = abs(velocity.x)
            let positionX = abs(finalX - Double(location.x))
            
            let velocityForce = sqrt(pow(velocity.x, 2) * pow(velocity.y, 2))
            
            let durationAnimation = (velocityForce > 1000.0) ? min(0.3, positionX / Double(horizentalVelocity)) : 0.3
            
            if velocityForce > 1000.0 {
                finalY += Double(velocity.y) * durationAnimation
            }
            
            if finalY > Double(UIScreen.main.bounds.size.height) - Double(customHeight/8*4.25) {
                finalY = Double(UIScreen.main.bounds.size.height) - Double(frameInset.bottom) - Double(customHeight/8*4.25)
            } else if finalY < Double(customHeight/8*4.25) + Double(frameInset.top)  {
                finalY = Double(customHeight/8*4.25) + Double(frameInset.top)
            }
            

            UIView.animate(withDuration: durationAnimation * 5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 6, options: .allowUserInteraction, animations: { [weak self] in
                self?.center = CGPoint(x: finalX, y: finalY)
                self?.transform = CGAffineTransform.identity
            }, completion:nil)
        }
    }
    
    func changeSideDisplay() {
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                       }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
