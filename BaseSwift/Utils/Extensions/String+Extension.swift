//
//  String+Extension.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 16/04/2023.
//

import Foundation
import CommonCrypto

extension String {
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return true
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func isValidPassWord() -> Bool {
        if self.isEmpty {
            return true
        }
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\dd$@$!%*?&#]{8,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: self)
    }
}

/// Extension for Symmetric Encryption and Decryption with DES, 3DES, AES algorithms
extension String {
    
    /// Encrypts message with DES algorithm
    func desEncrypt(key:String) -> String? {
        
        return symetricEncrypt(key: key, blockSize: kCCBlockSizeDES, keyLength: size_t(kCCKeySizeDES), algorithm: UInt32(kCCAlgorithmDES))
    }
    
    /// Encrypts message with 3DES algorithm
    func tripleDesEncrypt(key:String) -> String? {
        
        return symetricEncrypt(key: key, blockSize: kCCBlockSize3DES, keyLength: size_t(kCCKeySize3DES), algorithm: UInt32(kCCAlgorithm3DES))
    }
    
    /// Encrypts message with AES 128 algorithm
    func aes128Encrypt(key:String) -> String? {
        
        return symetricEncrypt(key: key, blockSize: kCCBlockSizeAES128, keyLength: size_t(kCCKeySizeAES128), algorithm: UInt32(kCCAlgorithmAES128))
    }
    
    /// Encrypts message with AES algorithm
    func aesEncrypt(key:String) -> String? {
        
        return symetricEncrypt(key: key, blockSize: kCCBlockSizeAES128, keyLength: size_t(kCCKeySizeAES256), algorithm: UInt32(kCCAlgorithmAES))
    }
    
    /// Encrypts a message with symmetric algorithm
    func symetricEncrypt(key:String, blockSize: Int, keyLength: size_t, algorithm: CCAlgorithm, options: Int = kCCOptionPKCS7Padding) -> String? {
        let keyData = key.data(using: String.Encoding.utf8)! as NSData
        let data = self.data(using: String.Encoding.utf8)! as NSData
        
        let cryptData = NSMutableData(length: Int(data.length) + blockSize)!
        
        let operation: CCOperation = UInt32(kCCEncrypt)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algorithm,
                                  UInt32(options),
                                  keyData.bytes, keyLength,
                                  nil,
                                  data.bytes, data.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            return base64cryptString
        }
        else {
            return nil
        }
    }
    
    /// Decrypts message with DES algorithm
    func desDecrypt(key:String) -> String? {
        
        return symetricDecrypt(key: key, blockSize: kCCBlockSizeDES, keyLength: size_t(kCCKeySizeDES), algorithm: UInt32(kCCAlgorithmDES))
    }
    
    /// Decrypts message with 3DES algorithm
    func tripleDesDecrypt(key:String) -> String? {
        
        return symetricDecrypt(key: key, blockSize: kCCBlockSize3DES, keyLength: size_t(kCCKeySize3DES), algorithm: UInt32(kCCAlgorithm3DES))
    }
    
    /// Decrypts message with AES 128 algorithm
    func aes128Decrypt(key:String) -> String? {
        
        return symetricDecrypt(key: key, blockSize: kCCBlockSizeAES128, keyLength: size_t(kCCKeySizeAES128), algorithm: UInt32(kCCAlgorithmAES128))
    }
    
    /// Decrypts message with AES algorithm
    func aesDecrypt(key:String) -> String? {
        
        return symetricDecrypt(key: key, blockSize: kCCBlockSizeAES128, keyLength: size_t(kCCKeySizeAES256), algorithm: UInt32(kCCAlgorithmAES))
    }
    
    /// Decrypts a message with symmetric algorithm
    func symetricDecrypt(key:String, blockSize: Int, keyLength: size_t, algorithm: CCAlgorithm, options: Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
           let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
           let cryptData    = NSMutableData(length: Int((data.length)) + blockSize) {
            
            let operation: CCOperation = UInt32(kCCDecrypt)
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algorithm,
                                      UInt32(options),
                                      (keyData as NSData).bytes, keyLength,
                                      nil,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
}

extension StringProtocol {
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
