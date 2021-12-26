//
//  ExtensionManager.swift
//  DisplayData
//
//  Created by FutureTeach on 22/12/21.
//

import Foundation
import UIKit

// MARK: - Cell Identifiers
class CellId{
    
    static let userDetailsTableViewCell = "UserDetailsTableViewCell"
}

// MARK: - DateFormat
func convertDateFormat(strDate:String) -> String {
    let date = strDate
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    if let yourDate = formatter.date(from: date) {
        formatter.dateFormat = "dd-MMM-yyyy"
        let finalconvertedDate = formatter.string(from: yourDate)
        return finalconvertedDate
    }
    return ""
    
}

// MARK: - CardView
@IBDesignable public class CardView: UIView {
    @IBInspectable var cornerradius : CGFloat = 5
    @IBInspectable var shadowoffSetWidth : CGFloat = 0
    @IBInspectable var shadowoffSetHeight : CGFloat = 0
    @IBInspectable var shadowColor : UIColor = UIColor(named: "borderColor") ?? UIColor.darkGray
    @IBInspectable var shadowOpacity : CGFloat = 0.5
    @IBInspectable var shadowRadius : CGFloat = 8
    @IBInspectable var BborderWidth : CGFloat = 0
    @IBInspectable var borderColour : UIColor = UIColor(named: "borderColor") ?? UIColor.orange

    override public func layoutSubviews() {
        layer.shadowColor = shadowColor.cgColor
        layer.cornerRadius = cornerradius
        layer.shadowOffset = .zero//CGSize(width: shadowoffSetWidth, height: shadowoffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = shadowRadius
        layer.borderColor = borderColour.cgColor
        layer.borderWidth = BborderWidth
    }
}

// MARK: - DisplayImage
extension UIImageView {
    func showImage(url:String) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
