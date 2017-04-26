//
//  IndexableDictionary.swift
//  IndexableDictionary
//
//  Created by Yuma Matsune on 2017/04/26.
//  Copyright © 2017年 matsune. All rights reserved.
//

import Foundation

struct IndexableDictionary<Key: Hashable, Value>: RandomAccessCollection, ExpressibleByArrayLiteral, RangeReplaceableCollection {
    
    // MARK: - Type Aliases
    
    public typealias Element = (key: Key, value: Value)
    
    public typealias SubSequence = IndexableDictionary
    
    public typealias Index = Int
    
    public typealias Indices = CountableRange<Int>
    
    private var _elements: [Element]
    
    // MARK: - Initializer
    
    public init() {
        _elements = []
    }
    
    public init(arrayLiteral elements: Element...) {
        _elements = elements
    }
    
    public init(array elements: [Element]) {
        _elements = elements
    }
    
    // MARK: - Subscript
    
    public subscript(position: Int) -> Element {
        get { return _elements[position] }
        set { _elements[position] = newValue }
    }
    
    public subscript(bounds: Range<Index>) -> SubSequence {
        let _array = (bounds.lowerBound..<bounds.upperBound).map { index -> Element in
            return self[index]
        }
        return IndexableDictionary(array: _array)
    }
    
    public subscript(key: Key) -> Value? {
        get {
            guard let index = index(where: {$0.key == key}) else { return nil }
            return self[index].value
        }
        set {
            if let value = newValue {
                if let index = index(where: {$0.key == key}) {
                    self[index] = (key, value)
                } else {
                    append((key, value))
                }
            } else {
                if let index = index(where: {$0.key == key}) {
                    remove(at: index)
                }
            }
        }
    }
    
    // MARK: - Indices
    
    var startIndex: Int { return _elements.startIndex }
    
    var endIndex  : Int { return _elements.endIndex }
    
    // MARK: - Range Replace
    
    mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, C.Iterator.Element == IndexableDictionary.Iterator.Element {
        _elements.replaceSubrange(subrange, with: newElements)
    }
}
