//
//  DCTikTokLoadingView.swift
//  列表播放
//
//  Created by 250508 on 2025/5/14.
//

import UIKit
enum DCBalldc_moveDirection {
    case dc_positive
    case dc_negative
}
class DCTikTokLoadingView: UIView {
    //MARK: - init
    @discardableResult @objc class func dc_showView(dc_superView: UIView) -> DCTikTokLoadingView? {
        let dc_loadingView = DCTikTokLoadingView.init(frame: dc_superView.bounds)
        dc_superView.addSubview(dc_loadingView)
        return dc_loadingView
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        dc_setViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func dc_setViews() {
        addSubview(dc_contentView)
        dc_contentView.addSubview(dc_greenView)
        dc_contentView.addSubview(dc_redView)
        dc_contentView.center = center
        dc_contentView.bounds = CGRectMake(0, 0, 2.1 * dc_ballWidth, 2.0 * dc_ballWidth)
        dc_greenView.center = CGPointMake(dc_ballWidth * 0.5, dc_contentView.bounds.size.height * 0.5)
        dc_redView.center = CGPointMake(dc_contentView.bounds.size.width - dc_ballWidth * 0.5, dc_contentView.bounds.size.height * 0.5)
        dc_contentView.bringSubviewToFront(dc_greenView)
        dc_updateBallPosition(dc_progress: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        dc_contentView.center = CGPointMake(bounds.size.width * 0.5, bounds.size.height * 0.5)
    }
    //MARK: - action
    func dc_startLoadingAction() {
        dc_startAnimationAction()
    }
    func dc_stopLoadingAction() {
        dc_stopAnimationAction()
    }
    func dc_startLoading(dc_progress: CGFloat) {
        dc_updateBallPosition(dc_progress: dc_progress)
    }
    @objc private func dc_startAnimationAction() {
        dc_pauseAnimationAction()
        dc_timer = CADisplayLink.init(target: self, selector: #selector(dc_updateBallAnimationsAction))
        dc_timer?.add(to: RunLoop.main, forMode: .common)
    }
    private func dc_pauseAnimationAction() {
        dc_timer?.invalidate()
        dc_timer = nil
    }
    private func dc_stopAnimationAction() {
        dc_timer?.invalidate()
        dc_timer = nil
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dc_startAnimationAction), object: nil)
        dc_greenView.addSubview(dc_blackView)
        dc_contentView.bringSubviewToFront(dc_greenView)
        dc_dc_moveDirection = .dc_positive
        dc_updateBallPosition(dc_progress: 0)
        
    }
    private func dc_resetAnimationAction() {
        dc_pauseAnimationAction()
        self.perform(#selector(dc_startAnimationAction), with: nil, afterDelay: dc_allPauseTime)
    }
    @objc private func dc_updateBallAnimationsAction() {
        if dc_dc_moveDirection == .dc_positive {
            // 更新绿球位置
            var dc_greenCenter = dc_greenView.center
            dc_greenCenter.x += dc_allSpeed
            dc_greenView.center = dc_greenCenter
            
            // 更新红球位置
            var dc_redCenter = dc_redView.center
            dc_redCenter.x -= dc_allSpeed
            dc_redView.center = dc_redCenter
            
            // 缩放动画，绿球放大，红球缩小
            dc_greenView.transform = dc_ballLargerTransformOfCenterX(dc_centerX: dc_greenView.center.x)
            dc_redView.transform = dc_ballSmallerTransformOfCenterX(dc_centerX: dc_redView.center.x)
            
            // 更新黑球位置
            let dc_blackViewFrame = dc_redView.convert(dc_redView.bounds, to: dc_greenView)
            dc_blackView.frame = dc_blackViewFrame
            dc_blackView.layer.cornerRadius = dc_blackView.bounds.width * 0.5
            
            // 更新方向
            if dc_greenView.frame.maxX >= dc_contentView.bounds.width || dc_redView.frame.minX <= 0 {
                dc_dc_moveDirection = .dc_negative
                dc_contentView.bringSubviewToFront(dc_redView)
                dc_redView.addSubview(dc_blackView)
                dc_resetAnimationAction()
            }
            return
        }
        // 更新绿球位置
        var dc_greenCenter = dc_greenView.center
        dc_greenCenter.x -= dc_allSpeed
        dc_greenView.center = dc_greenCenter
        
        // 更新红球位置
        var dc_redCenter = dc_redView.center
        dc_redCenter.x += dc_allSpeed
        dc_redView.center = dc_redCenter
        
        // 缩放动画，红球放大，绿球缩小
        dc_redView.transform = dc_ballLargerTransformOfCenterX(dc_centerX: dc_redView.center.x)
        dc_greenView.transform = dc_ballSmallerTransformOfCenterX(dc_centerX: dc_greenView.center.x)
        
        // 更新黑球位置
        let dc_blackViewFrame = dc_greenView.convert(dc_greenView.bounds, to: dc_redView)
        dc_blackView.frame = dc_blackViewFrame
        dc_blackView.layer.cornerRadius = dc_blackView.bounds.width * 0.5
        
        // 更新方向
        if dc_greenView.frame.minX <= 0 || dc_redView.frame.maxX >= dc_contentView.bounds.width {
            dc_dc_moveDirection = .dc_positive
            dc_contentView.bringSubviewToFront(dc_greenView)
            dc_greenView.addSubview(dc_blackView)
            dc_resetAnimationAction()
        }
    }
    private func dc_updateBallPosition(dc_progress: CGFloat) {
        var dc_greenCenter = dc_greenView.center
        dc_greenCenter.x = dc_ballWidth * 0.5 + 1.1 * dc_ballWidth * dc_progress
        dc_greenView.center = dc_greenCenter
        
        var dc_redCenter = dc_greenView.center
        dc_redCenter.x = dc_ballWidth * 1.6 - 1.1 * dc_ballWidth * dc_progress
        dc_redView.center = dc_redCenter
        
        // 缩放动画，绿球放大，红球缩小
        if dc_progress != 0 && dc_progress != 1 {
            dc_greenView.transform = dc_ballLargerTransformOfCenterX(dc_centerX: dc_greenView.center.x)
            dc_redView.transform = dc_ballSmallerTransformOfCenterX(dc_centerX: dc_redView.center.x)
        } else {
            dc_greenView.transform = .identity
            dc_redView.transform = .identity
        }
        
        // 更新黑球位置
        let dc_blackFrame = dc_redView.convert(dc_redView.bounds, to: dc_greenView)
        dc_blackView.frame = dc_blackFrame
        dc_blackView.layer.cornerRadius = dc_blackView.bounds.width * 0.5
    }
    // 放大动画
    private func dc_ballLargerTransformOfCenterX(dc_centerX: CGFloat) -> CGAffineTransform {
        let dc_cosValue = dc_cosValueOfCenterX(dc_centerX: dc_centerX)
        return CGAffineTransform(scaleX: 1 + dc_cosValue * dc_allZoomScale, y:  1 + dc_cosValue * dc_allZoomScale)
    }
    // 缩小动画
    private func dc_ballSmallerTransformOfCenterX(dc_centerX: CGFloat) -> CGAffineTransform {
        let dc_cosValue = dc_cosValueOfCenterX(dc_centerX: dc_centerX)
        return CGAffineTransform(scaleX: 1 - dc_cosValue * dc_allZoomScale, y:  1 - dc_cosValue * dc_allZoomScale)
    }
    // 根据余弦函数获取变化区间 变化范围是0~1~0
    private func dc_cosValueOfCenterX(dc_centerX: CGFloat) -> CGFloat {
        // 计算 centerX 与容器中心的偏移量
        let dc_apart = dc_centerX - dc_contentView.bounds.width * 0.5
        // 计算最大偏移量（容器宽度减去球的宽度的一半）
        let dc_maxApart = (dc_contentView.bounds.width - dc_ballWidth) * 0.5
        // 计算角度（将偏移量映射到 0 到 π/2 的范围）
        let dc_angle = dc_apart / dc_maxApart * (.pi / 2)
        // 返回余弦值，范围在 0 到 1 之间
        return cos(dc_angle)
    }
    //MARK: - lazy
    private lazy var dc_contentView: UIView = {
        let dc_contentView = UIView()
        return dc_contentView
    }()
    private lazy var dc_greenView: UIView = {
        let dc_greenView = UIView(frame: CGRectMake(0, 0, dc_ballWidth, dc_ballWidth))
        dc_greenView.backgroundColor = .green
        dc_greenView.layer.cornerRadius = dc_ballWidth * 0.5
        dc_greenView.layer.masksToBounds = true
        return dc_greenView
    }()
    private lazy var dc_redView: UIView = {
        let dc_redView = UIView(frame: CGRectMake(0, 0, dc_ballWidth, dc_ballWidth))
        dc_redView.backgroundColor = .red
        dc_redView.layer.cornerRadius = dc_ballWidth * 0.5
        dc_redView.layer.masksToBounds = true
        return dc_redView
    }()
    private lazy var dc_blackView: UIView = {
        let dc_blackView = UIView(frame: CGRectMake(0, 0, dc_ballWidth, dc_ballWidth))
        dc_blackView.backgroundColor = .black
        dc_blackView.layer.cornerRadius = dc_ballWidth * 0.5
        dc_blackView.layer.masksToBounds = true
        return dc_blackView
    }()
    private var dc_dc_moveDirection:DCBalldc_moveDirection = .dc_positive
    private var dc_timer: CADisplayLink?
    private var dc_ballWidth  =      12.0
    private var dc_allSpeed   =   0.7
    private var dc_allZoomScale =   0.25
    private var dc_allPauseTime = 0.18
}
