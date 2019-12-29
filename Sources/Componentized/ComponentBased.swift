//
//  Copyright © 2018 Apparata AB. All rights reserved.
//

import Foundation

/// Represents an object with a component based structure.
public protocol ComponentBased {
    
    /// Each componentized object must have its own component store instance,
    /// where its components will be stored.
    var componentStore: ComponentStore { get }
    
    /// Optionally returns a component of type T, if this object's component
    /// store contains one.
    ///
    /// Default implementation invokes component() on componentStore.
    ///
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    func component<T>() -> T?
    
    /// Optionally returns a component of type T, if this object's component
    /// store contains one.
    ///
    /// Default implementation invokes component() on componentStore.
    ///
    /// - parameter type: Explicitly name the type of the component to return.
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    func component<T>(_ type: T.Type) -> T?
    
    /// Optionally returns a component of type T, with an extra qualifier to
    /// differentiate between components of the same type, if this object's
    /// component store contains one.
    ///
    /// Default implementation invokes component(qualifier:) on componentStore.
    ///
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    func component<T, Q: Hashable>(qualifier: Q) -> T?

    /// Optionally returns a component of type T, with an extra qualifier to
    /// differentiate between components of the same type, if this object's
    /// component store contains one.
    ///
    /// Default implementation invokes component(qualifier:) on componentStore.
    ///
    /// - parameter type: Explicitly name the type of the component to return.
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a matching component of generic type T, if there is
    ///            one. Otherwise, `nil`.
    func component<T, Q: Hashable>(_ type: T.Type, qualifier: Q) -> T?
    
    /// Returns a required component of type T, where required means that this
    /// method will crash if there is no matching component. It should only
    /// be used for components that are guaranteed to exist.
    ///
    /// Default implementation invokes requiredComponent() on componentStore.
    ///
    /// - returns: Returns a required matching component of generic type T.
    func requiredComponent<T>() -> T

    /// Returns a required component of type T, where required means that this
    /// method will crash if there is no matching component. It should only
    /// be used for components that are guaranteed to exist.
    ///
    /// Default implementation invokes requiredComponent() on componentStore.
    ///
    /// - parameter type: Explicitly name the type of the component to return.
    /// - returns: Returns a required matching component of generic type T.
    func requiredComponent<T>(_ type: T.Type) -> T

    /// Returns a required component of type T, with an extra qualifier to
    /// differentiate between components of the same type, where required means
    /// that this method will crash if there is no matching component. It
    /// should only be used for components that are guaranteed to exist.
    ///
    /// Default implementation invokes requiredComponent(qualifier:) on componentStore.
    ///
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a required matching component of generic type T.
    func requiredComponent<T, Q: Hashable>(qualifier: Q) -> T

    /// Returns a required component of type T, with an extra qualifier to
    /// differentiate between components of the same type, where required means
    /// that this method will crash if there is no matching component. It
    /// should only be used for components that are guaranteed to exist.
    ///
    /// Default implementation invokes requiredComponent(qualifier:) on componentStore.
    ///
    /// - parameter type: Explicitly name the type of the component to return.
    /// - parameter qualifier: Qualifier to differentiate between components
    ///                        of same type.
    /// - returns: Returns a required matching component of generic type T.
    func requiredComponent<T, Q: Hashable>(_ type: T.Type, qualifier: Q) -> T
}

// ----------------------------------------------------------------------------
// MARK: - Default Implementations
// ----------------------------------------------------------------------------

// Default implementations of everything but the component store.
extension ComponentBased {
    
    func component<T>() -> T? {
        return componentStore.component() as T?
    }
    
    func component<T, Q: Hashable>(qualifier: Q) -> T? {
        return componentStore.component(qualifier: qualifier)
    }
    
    func requiredComponent<T>() -> T {
        return componentStore.requiredComponent()
    }
    
    func requiredComponent<T, Q: Hashable>(qualifier: Q) -> T {
        return componentStore.requiredComponent(qualifier: qualifier)
    }
}

