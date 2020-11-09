//
//  MarkdownItalic.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownItalic: MarkdownCommonElement {
    fileprivate static let regex = "(\\s|^)(\\*|_)(?![\\*_\\s])(.+?)(?<![\\*_\\s])(\\2)"

    open var font: MarkdownFont?
    open var color: MarkdownColor?

    open var regex: String {
        return MarkdownItalic.regex
    }

    public init(font: MarkdownFont?, color: MarkdownColor? = nil) {
        self.font = font?.italic()
        self.color = color
    }

    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 4))

        // formatting string (may alter the length)
        let stringAttributes = attributedString.attributes(at: match.range(at: 3).location, longestEffectiveRange: nil, in: match.range(at: 3))
        addAttributes(attributedString, range: match.range(at: 3))
        if let font = font,
           let stringFont = stringAttributes[.font] as? MarkdownFont
        {
            let fontSize: CGFloat = stringFont.fontDescriptor.pointSize
            let fontTraits = stringFont.fontDescriptor.symbolicTraits

            /// Set matrix, fix italic no work in chinese
            let matrix = CGAffineTransform(a: 1, b: 0, c: CGFloat(tanf(10 * .pi / 180)), d: 1, tx: 0, ty: 0)
            let desc = UIFontDescriptor(name: "", matrix: matrix)
            var italicFont: MarkdownFont = font.withSize(fontSize)
            italicFont = UIFont(descriptor: desc, size: fontSize)
            italicFont = italicFont.withTraits(fontTraits) ?? italicFont
            
            attributedString.addAttributes([NSAttributedString.Key.font: italicFont], range: match.range(at: 3))
        }

        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
    }
}
