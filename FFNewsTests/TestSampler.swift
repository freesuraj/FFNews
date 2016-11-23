//
//  TestSampler.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct TestSampler {
    
    private let dictionary: NSDictionary
    static let shared: TestSampler = TestSampler()
    
    private init() {
        if let path = Bundle(for: ArticleTest.self).path(forResource: "SampleJson", ofType: "plist"), let dict = NSDictionary.init(contentsOfFile: path) {
            self.dictionary = dict
        } else {
            self.dictionary = NSDictionary()
        }
    }
    
    func valueForKeyPath(_ keypath: String...) -> Any? {
        let keys: [String] = keypath
        var currentDictionary = dictionary
        for (index, aKey) in keys.enumerated() {
            if index == keys.count - 1, let value = currentDictionary.value(forKey: aKey) as? String ,
                let data = value.data(using: String.Encoding.utf8, allowLossyConversion: true),
                let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                return json
            }
            guard let dict = currentDictionary.value(forKey: aKey) as? NSDictionary else {
                return nil
            }
            currentDictionary = dict
        }
        return nil
    }
    
}
