//
//  Copyright © 2018 Apparata AB. All rights reserved.
//

import Foundation

/// Stores added components for objects with component based structure,
/// i.e. objects that implement the `ComponentBased` protocol.
/// Each component based object must have its own instance of the store.
public final class ComponentStore {
    
    private typealias Component = Any
    
    private var components = [ComponentIdentifier: Component]()
    
    /// Add a component of type T to component store.
    ///
    /// - parameter component: The component to add to the component store.
    public func addComponent<T: Any>(_ component: T) {
        let id = ComponentIdentifier(type: T.self)
        components[id] = component
    }
    
    /// Add a component of type T, with an extra qualifier of type T to
    /// differentiate between components of the same type, to component store.
    ///
    /// - parameter component: The component to add to the component store.
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    public func addComponent<T: Any, Q: Hashable>(_ component: T, qualifier: Q) {
        let id = ComponentIdentifier(type: T.self, qualifier: qualifier)
        components[id] = component
    }
    
    /// Optionally returns a component of type T, if this component store
    /// contains one.
    ///
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    public func component<T>() -> T? {
        let id = ComponentIdentifier(type: T.self)
        let component = components[id] as? T
        return component
    }
    
    /// Optionally returns a component of type T, with an extra qualifier to
    /// differentiate between components of the same type, if this component
    /// store contains one.
    ///
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    public func component<T, Q: Hashable>(qualifier: Q) -> T? {
        let id = ComponentIdentifier(type: T.self, qualifier: qualifier)
        let component = components[id] as? T
        return component
    }
    
    /// Returns a required component of type T, where required means that this
    /// method will crash if there is no matching component. It should only
    /// be used for components that are guaranteed to exist.
    ///
    /// - returns: Returns a required matching component of generic type T.
    public func requiredComponent<T>() -> T {
        let id = ComponentIdentifier(type: T.self)
        let component = components[id] as! T
        return component
    }
    
    /// Returns a required component of type T, with an extra qualifier to
    /// differentiate between components of the same type, where required means
    /// that this method will crash if there is no matching component. It
    /// should only be used for components that are guaranteed to exist.
    ///
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a required matching component of generic type T.
    public func requiredComponent<T, Q: Hashable>(qualifier: Q) -> T {
        let id = ComponentIdentifier(type: T.self, qualifier: qualifier)
        let component = components[id] as! T
        return component
    }
}

// ---------------------------------------------------------------------------
// MARK: - Internal Support
// ---------------------------------------------------------------------------

fileprivate struct ComponentIdentifier: Hashable {
    
    fileprivate let type: Any.Type
    fileprivate let qualifier: Int?
    fileprivate let id: String
    
    init(type: Any.Type) {
        self.type = type
        self.qualifier = nil
        id = "\(type)"
    }
    
    init<Q>(type: Any.Type, qualifier: Q) where Q: Hashable {
        self.type = type
        self.qualifier = qualifier.hashValue
        id = "\(type) \(qualifier.hashValue)"
    }
    
    static func == (lhs: ComponentIdentifier, rhs: ComponentIdentifier) -> Bool {
        return lhs.type == rhs.type && lhs.qualifier == rhs.qualifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
