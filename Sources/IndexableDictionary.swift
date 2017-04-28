//
//  IndexableDictionary.swift
//  IndexableDictionary
//
//  Created by Yuma Matsune on 2017/04/26.
//  Copyright © 2017年 matsune. All rights reserved.
//

public struct IndexableDictionary<Key: Hashable, Value>: RandomAccessCollection, ExpressibleByArrayLiteral, RangeReplaceableCollection, BidirectionalCollection {
    
    // MARK: - Type Aliases
    
    public typealias Element = (key: Key, value: Value)
    
    public typealias SubSequence = IndexableDictionary
    
    public typealias Index = Int
    
    public typealias Indices = CountableRange<Int>
    
    fileprivate var _elements: [Element]
    
    // MARK: - Initializer
    
    public init() {
        _elements = []
    }
    
    public init(arrayLiteral elements: Element...) {
        _elements = elements
    }
    
    public init(_ elements: [Element]) {
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
        return IndexableDictionary(_array)
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
    
    public var startIndex: Index { return _elements.startIndex }
    
    public var endIndex  : Index { return _elements.endIndex }
    
    public func index(forKey key: Key) -> Index? {
        return _elements.index(where: {$0.0 == key})
    }
    
    // MARK: - Range Replace
    
    public mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, C.Iterator.Element == IndexableDictionary.Iterator.Element {
        _elements.replaceSubrange(subrange, with: newElements)
    }
    
    // MARK: - Dictionary property
    
    public var keys: LazyMapCollection<IndexableDictionary, Key> { return lazy.map {$0.key} }
    
    public var values: LazyMapCollection<IndexableDictionary, Value> { return lazy.map {$0.value} }
    
    public mutating func removeValue(forKey key: Key) -> Value? {
        guard let index = index(forKey: key) else { return nil }
        return remove(at: index).value
    }
    
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        guard let oldValue = self[key] else {
            self[key] = value
            return nil
        }
        self[key] = value
        return oldValue
    }
}

// MARK: - Operator

extension IndexableDictionary where Value: Equatable {
    public static func ==(lhs: IndexableDictionary, rhs: IndexableDictionary) -> Bool {
        return lhs.keys.elementsEqual(rhs.keys) && lhs.values.elementsEqual(rhs.values)
    }
}
