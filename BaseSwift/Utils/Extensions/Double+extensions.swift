import Foundation
import UIKit

extension Double{
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
    func formatAsNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3

        let num = NSNumber(value: self)
        return formatter.string(from: num) ?? ""
    }
    
    func formatAsCount() -> String {
        let num = self
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000 {
            if floor(thousandNum) == thousandNum {
                return("\(thousandNum.formatAsNumber())")
            }
            return("\(thousandNum.roundToPlaces(places: 1).formatAsNumber())k")
        }
        if num > 1000000 {
            if floor(millionNum) == millionNum {
                return("\(thousandNum.formatAsNumber())k")
            }
            return ("\(millionNum.roundToPlaces(places: 1).formatAsNumber())m")
        } else {
            if floor(num) == num {
                return ("\(num.formatAsNumber())")
            }
            return ("\(num.formatAsNumber())")
        }
    }
    
}

extension FixedWidthInteger {
    var data: Data {
        let data = withUnsafeBytes(of: self) { Data($0) }
        return data
    }
}
