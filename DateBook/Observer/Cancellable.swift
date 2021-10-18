//
//  Cancellable.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation


protocol Cancellable: AnyObject {
    func cancel()
}


class Subscribtion: Cancellable {
    
    
    weak var publisher: PublisherProtocol?
    
    
    weak var observable: Observer?
    
    
    func cancel() {
        guard let observable = observable else {return}
        publisher?.unsubscribe(observable)
        
    }
    
    
    init(publisher: PublisherProtocol, observable: Observer) {
        self.publisher = publisher
        self.observable = observable
    }
    
    
    deinit {
        cancel()
    }
    
}
