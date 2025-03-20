//
//  PODAExtension.swift
//  PopcornDrama
//
//  Created by peodgo on 1/14/25.
//

import UIKit

extension UIView {
    @objc static var poda_viewToString: String {
        return NSStringFromClass(self.classForCoder())
    }
    @objc var poda_viewGetVController: UIViewController? {
        var next = self.next
        while next != nil {
            if let vc = next as? UIViewController {
                return vc
            }
            next = next?.next
        }
        return nil
    }
    @objc func poda_addTap(poda_target: Any? = nil, action: Selector) {
        self.isUserInteractionEnabled = true
        guard let poda_target = poda_target else {
            let tap = UITapGestureRecognizer.init(target: self, action: action)
            addGestureRecognizer(tap)
            return
        }
        let tap = UITapGestureRecognizer.init(target: poda_target, action: action)
        addGestureRecognizer(tap)
    }
    @discardableResult @objc func poda_addLong(poda_target: Any? = nil, action: Selector) -> UILongPressGestureRecognizer {
        self.isUserInteractionEnabled = true
        guard let poda_target = poda_target else {
            let tap = UILongPressGestureRecognizer.init(target: self, action: action)
            addGestureRecognizer(tap)
            return tap
        }
        let tap = UILongPressGestureRecognizer.init(target: poda_target, action: action)
        addGestureRecognizer(tap)
        return tap
    }
    var poda_top: CGFloat {
        get{
            return frame.origin.y
        }
        set(poda_top) {
            frame.origin.y = poda_top
        }
    }
    var poda_left: CGFloat {
        get{
            return frame.origin.x
        }
        set(poda_left) {
            frame.origin.x = poda_left
        }
    }
    var poda_bottom: CGFloat {
        get{
            return frame.origin.y + frame.size.height
        }
        set(poda_bottom) {
            frame.origin.y = poda_bottom - frame.size.height
        }
    }
    var poda_right: CGFloat {
        get{
            return frame.origin.x + frame.size.width
        }
        set(poda_right) {
            frame.origin.x = poda_right - bounds.size.width
        }
    }
    var poda_width: CGFloat {
        get{
            return frame.size.width
        }
        set(poda_width) {
            frame.size.width = poda_width
        }
    }
    var poda_height: CGFloat {
        get{
            return frame.size.height
        }
        set(poda_height) {
            frame.size.height = poda_height
        }
    }
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(centerX) {
            center.x  = centerX
        }
    }
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(centerY) {
            center.y  = centerY
        }
    }
    var poda_size: CGSize {
        get{
            return frame.size
        }
        set(poda_size) {
            frame.size = poda_size
        }
    }
    var origin: CGPoint {
        get{
            return frame.origin
        }
        set(origin) {
            frame.origin = origin
        }
    }
    //移除所有子视图
    func poda_removeAllSupViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    func poda_removeSupView(poda_tag: NSInteger = 0) {
        let poda_view = viewWithTag(poda_tag)
        poda_view?.removeFromSuperview()
    }
    //遍历获取指定 view
    func poda_findScrollView() -> UIScrollView? {
        for poda_subView in self.subviews {
            if let poda_scorView = poda_subView as? UIScrollView {
                return poda_scorView
            } else if let poda_scorView = poda_subView.poda_findScrollView() {
                return poda_scorView
            }
        }
        return nil
    }
    // 添加阴影
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = .zero,
        radius: CGFloat = 5,
        shouldRasterize: Bool = false
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
        layer.shouldRasterize = shouldRasterize
        layer.rasterizationScale = UIScreen.main.scale
    }

}
extension String {
    func poda_getStringHeight(poda_w: CGFloat, poda_font: UIFont) -> CGFloat {
        
        return self.boundingRect(with: CGSize(width: poda_w, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: poda_font], context: nil).size.height
    }
    func poda_getLineStringHeight(poda_w: CGFloat, poda_font: UIFont,poda_line: Int = 2) ->  (poda_singleHeight: CGFloat, poda_multipleLineHeight: CGFloat) {
        // 计算单行文本高度
        let poda_singleHeight = "A".size(withAttributes: [.font: poda_font]).height
        // 计算两行文本高度（最多两行）
        let poda_maxHeight = poda_singleHeight * CGFloat(poda_line)
        let poda_constraintSize = CGSize(width: poda_w, height: poda_maxHeight)
        let poda_boundingBox = self.boundingRect(
            with: poda_constraintSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: poda_font],
            context: nil
        )
        let poda_multipleLineHeight = min(ceil(poda_boundingBox.height), poda_maxHeight)
        return (poda_singleHeight, poda_multipleLineHeight)
    }
    func poda_getStringWidth(poda_w: CGFloat, poda_font: UIFont) -> CGFloat {
        
        return self.boundingRect(with: CGSize(width: poda_w, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: poda_font], context: nil).size.width
    }
    func poda_getAttributedString(target: String) -> NSAttributedString {
        // 创建一个空的可变属性字符串
        let attributedString = NSMutableAttributedString(string: self)
        // 设置整个字符串为白色字体
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: self.count))
        
        // 查找目标文字在文本中的位置
        if let range = self.range(of: target) {
            // 将目标文字的 NSRange 转换为适配的 Swift 范围
            let nsRange = NSRange(range, in: self)
            
            // 设置目标文字为红色字体
            attributedString.addAttribute(.foregroundColor, value: PODACommon.poda_getHXColorValue(rgb: 0xFF432B), range: nsRange)
        }
        
        return attributedString
    }
    func poda_stringValueDic() -> [String : Any]?{
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!,
                                                        options: .mutableContainers) as? [String : Any] {
            return dict
        }
        
        return nil
    }
    var pdoa_isBlank: Bool {
        self.isEmpty || self.allSatisfy { $0.isWhitespace }
    }
}
//MARK: - UIButton
extension UIButton {
    convenience init(poda_title: String,poda_color: UIColor?,poda_fontSize: CGFloat?,poda_weight: UIFont.Weight = .medium,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        setTitle(poda_title, for: .normal)
        if let poda_color = poda_color {
            setTitleColor(poda_color, for: .normal)
        }
        if let poda_fontSize = poda_fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: poda_fontSize,weight: poda_weight)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_title: String,poda_color: UIColor?,poda_fontSize: CGFloat?,poda_weight: UIFont.Weight = .medium,poda_imageName: String,poda_selectImageName: String? = nil,poda_target: AnyObject? = nil, poda_actionName: Selector? = nil) {
        self.init()
        setTitle(poda_title, for: .normal)
        if let poda_color = poda_color {
            setTitleColor(poda_color, for: .normal)
        }
        if let poda_fontSize = poda_fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: poda_fontSize,weight: poda_weight)//UIFont.poda_scaledFont(poda_fontSize: poda_fontSize, poda_weight: poda_weight)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        setImage(UIImage(named: poda_imageName), for: .normal)
        if let poda_selectImageName = poda_selectImageName {
            setImage(UIImage(named: poda_selectImageName), for: .selected)
        }
        sizeToFit()
    }
    convenience init(poda_title: String,poda_color: UIColor?,poda_fontSize: CGFloat?,poda_weight: UIFont.Weight = .medium,poda_backgroundImageName: String?,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        setTitle(poda_title, for: .normal)
        if let poda_color = poda_color {
            setTitleColor(poda_color, for: .normal)
        }
        if let poda_fontSize = poda_fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: poda_fontSize,weight: poda_weight)//UIFont.poda_scaledFont(poda_fontSize: poda_fontSize, poda_weight: poda_weight)//UIFont.systemFont(ofSize: poda_fontSize)
        }
        if let poda_backgroundImageName = poda_backgroundImageName {
            setBackgroundImage(UIImage(named: poda_backgroundImageName), for: .normal)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_imageName: String?, poda_selectImageName: String?,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        if let poda_imageName = poda_imageName {
            setImage(UIImage(named: poda_imageName), for: .normal)
        }
       
        
        if let poda_selectImageName = poda_selectImageName {
            setImage(UIImage(named: poda_selectImageName), for: .selected)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_imageName: String,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        
        setImage(UIImage(named: poda_imageName), for: .normal)
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_title: String, poda_normalcolor: UIColor?,poda_selectedlColor: UIColor?, poda_fontSize: CGFloat?,poda_weight: UIFont.Weight = .medium, poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        
        setTitle(poda_title, for: .normal)
        if let poda_normalcolor = poda_normalcolor {
            setTitleColor(poda_normalcolor, for: .normal)
        }
        if let poda_selectedlColor = poda_selectedlColor {
            setTitleColor(poda_selectedlColor, for: .selected)
        }
        if let poda_fontSize = poda_fontSize {
            titleLabel?.font = UIFont.systemFont(ofSize: poda_fontSize,weight: poda_weight)//UIFont.poda_scaledFont(poda_fontSize: poda_fontSize, poda_weight: poda_weight)//UIFont.systemFont(ofSize: poda_fontSize)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_imageName: String,poda_backgroundImageName: String,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        setImage(UIImage(named: poda_imageName), for: .normal)
        setBackgroundImage(UIImage(named: poda_backgroundImageName), for: .normal)
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_backgroundImageName: String,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        setBackgroundImage(UIImage(named: poda_backgroundImageName), for: .normal)
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
    convenience init(poda_backgroundImageName: String?,poda_selectBackgroundImageName: String?,poda_target: AnyObject?, poda_actionName: Selector?) {
        self.init()
        if let poda_backgroundImageName = poda_backgroundImageName {
            setBackgroundImage(UIImage(named: poda_backgroundImageName), for: .normal)
        }
        if let poda_selectBackgroundImageName = poda_selectBackgroundImageName {
            setBackgroundImage(UIImage(named: poda_selectBackgroundImageName), for: .selected)
        }
        if let poda_actionName = poda_actionName {
            self.addTarget(poda_target, action: poda_actionName, for: .touchUpInside)
        }
        sizeToFit()
    }
}
//MARK: - UILabel
extension UILabel {
    convenience init(poda_textColor:UIColor,poda_fontSize:CGFloat,poda_weight: UIFont.Weight = .medium) {
        self.init()
        self.textColor = poda_textColor
        self.font = UIFont.poda_scaledFont(poda_fontSize: poda_fontSize,poda_weight: poda_weight)//UIFont.systemFont(ofSize: poda_fontSize)
    }
    convenience init(poda_textColor:UIColor,poda_fontSize:CGFloat,poda_numberOfLines:Int,poda_weight: UIFont.Weight = .medium) {
        self.init()
        self.textColor = poda_textColor
        self.font = UIFont.poda_scaledFont(poda_fontSize: poda_fontSize,poda_weight: poda_weight)//UIFont.systemFont(ofSize: poda_fontSize)
        self.numberOfLines = poda_numberOfLines
    }
    
}
//MARK: - UIImage
extension UIImage {
    //给定宽度，返回图片
    func poda_displayImageWithWidth(poda_width:CGFloat) -> UIImage {
        let height =  self.size.height * poda_width / self.size.width
        let rect = CGRect(x: 0, y: 0, width: poda_width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        self.draw(in: rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img!
    }
}
//MARK: -  CGFloat
extension CGFloat {
    static func poda_scaledCGFloatValue(poda_value: CGFloat) -> CGFloat {
        return poda_value * poda_SCREEN_WIDTH / 375.0
    }
    func poda_fontSizeChangeAction() -> CGFloat {
        let poda_value = self * poda_SCREEN_WIDTH / 375.0
        return poda_value > self ? poda_value : self
    }
}
//MARK: -  UIFont
extension UIFont {
    static func poda_scaledFont(poda_fontSize: CGFloat,poda_weight: UIFont.Weight = .medium) -> UIFont {
        return UIFont.systemFont(ofSize: poda_fontSize.poda_fontSizeChangeAction(), weight: poda_weight)
    }
}
//MARK: -  Array
extension [String:Any]{
    func poda_jsonString() -> String? {
        guard let poda_jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        if let poda_jsonString = String(data: poda_jsonData, encoding: .utf8) {
            return poda_jsonString
        }
        return nil
    }
}
extension NSArray {
    func poda_jsonString() -> String? {
        guard let poda_jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        if let poda_jsonString = String(data: poda_jsonData, encoding: .utf8) {
            return poda_jsonString
        }
        return nil
    }
}
extension NSInteger {
    func poda_formatTime() -> String {
        let poda_h = self / 3600
        let poda_m = (self % 3600) / 60
        let poda_s = self % 60
        var poda_time = String(format: "%02d:%02d:%02d", poda_h, poda_m, poda_s)
        if poda_h == 0 {
            poda_time = String(format: "%02d:%02d", poda_m, poda_s)
        }
        
        return poda_time
    }
}
extension UIColor {
    static func pdoa_randomAction() -> UIColor {
        return UIColor(red: .random(in: 0.3...1), green: .random(in: 0.3...1), blue: .random(in: 0.3...1), alpha: 1)
    }
}
