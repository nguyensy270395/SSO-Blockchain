import UIKit

class BaseLabel: UILabel {
    
    @IBInspectable public var lineHeight: CGFloat = 0{
        didSet{
            updateText()
        }
    }
    @IBInspectable public var lineSpace: CGFloat = 0{
        didSet{
            updateText()
        }
    }
    @IBInspectable public var charSpacing: CGFloat = 0{
        didSet{
            updateText()
        }
    }
  
    override var text: String?{
        didSet{
            updateText()
        }
    }
    private func updateText(){
        self.setTextWith(text: text, font: self.font, lineHeight: lineHeight, lineSpacing: lineSpace, characterSpacing: charSpacing, breakMode: self.lineBreakMode, alignment: self.textAlignment)
        setNeedsLayout()
    }
    override func drawText(in rect: CGRect) {
        //bottom  = 2  text will be not cut at bottom
        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 2, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        return CGSize(width: size.width + insets.left + insets.right, height: size.height + insets.top + insets.bottom)
    }
    
}


extension UILabel{
    
    func setTextWith(text: String?, font: UIFont, lineHeight: CGFloat? = 0,
                     lineSpacing: CGFloat? = 0, characterSpacing: CGFloat? = 0,
                     breakMode: NSLineBreakMode? = .byCharWrapping, alignment: NSTextAlignment? = .left) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineHeight = lineHeight,lineHeight > 0 {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        paragraphStyle.lineSpacing = lineSpacing ?? 0
        paragraphStyle.lineBreakMode = breakMode ?? self.lineBreakMode
        paragraphStyle.alignment = alignment ?? self.textAlignment
        attributes.updateValue(paragraphStyle, forKey: .paragraphStyle)
        if let characterSpacing = characterSpacing{
            if #available(iOS 14.0, *) {
                attributes.updateValue(characterSpacing/50, forKey: NSAttributedString.Key.tracking)
            } else {
                // Fallback on earlier versions
                attributes.updateValue(characterSpacing/50, forKey: NSAttributedString.Key.kern)
            }
        }
        attributes.updateValue( font, forKey: NSAttributedString.Key.font)
        self.attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
    }
}
