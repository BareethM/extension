//
//  Extension + Dict.swift
//  Extensions
//
//  Created by Bareeth on 03/05/24.
//

import Foundation

public typealias JSONVALUE = [String: Any]

public extension Dictionary where Dictionary == JSONVALUE {
    var status_code: Int {
        return Int(self["status_code"] as? String ?? "") ?? 0
    }
    
    
    var isSuccess: Bool {
        return status_code != 0
    }
    
    init?(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
            self = json
        } else {
            return nil
        }
    }
    
    var status_message: String {
        let statusMessage = self.string("status_message")
        let successMessage = self.string("success_message")
        return statusMessage.isEmpty ? successMessage : statusMessage
    }
    
    func array<T>(_ key: String) -> [T] {
        return self[key] as? [T] ?? []
    }
    
    func array(_ key: String) -> [JSONVALUE] {
        return self[key] as? [JSONVALUE] ?? []
    }
    
    func json(_ key: String) -> JSONVALUE {
        return self[key] as? JSONVALUE ?? JSONVALUE()
    }
    
    func string(_ key: String) -> String {
        let value = self[key]
        if let str = value as? String {
            return str
        } else if let int = value as? Int {
            return String(int)
        } else if let double = value as? Double {
            return String(double)
        } else {
            return ""
        }
    }
    
    func nsString(_ key: String) -> NSString {
        return self.string(key) as NSString
    }
    
    func int(_ key: String) -> Int {
        let value = self[key]
        if let str = value as? String {
            return Int(str) ?? 0
        } else if let int = value as? Int {
            return int
        } else if let double = value as? Double {
            return Int(double)
        } else {
            return 0
        }
    }
    
    func double(_ key: String) -> Double {
        let value = self[key]
        if let str = value as? String {
            return Double(str) ?? 0.0
        } else if let int = value as? Int {
            return Double(int)
        } else if let double = value as? Double {
            return double
        } else {
            return 0.0
        }
    }
    
    func bool(_ key: String) -> Bool {
        let value = self[key]
        if let bool = value as? Bool {
            return bool
        } else if let int = value as? Int {
            return int == 1
        } else if let str = value as? String {
            return ["1", "true"].contains(str)
        } else {
            return false
        }
    }
}
