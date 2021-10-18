//
//  DataPublisher.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation



class DataPublisher<Data>: PublisherProtocol{
   
    
    private var _data: Data
    
    
    var data: Data{
        get{
            _data
        }
        set{
            _data = newValue
            notify()
        }
    }
    
    
    weak var observableObject: ObservableObject? = nil
    
    
    private var observers = [Observer]()
    
    
    init(initial: Data, observableObject: ObservableObject?) {
        _data = initial
        self.observableObject = observableObject
    }
    
    
    func sink(update:@escaping() -> Void) -> Cancellable{
        let subscriber = EscapingSubscriber.init(closure: update)
        subscribe(subscriber)
        
        let subscription = Subscribtion(publisher: self, observable: subscriber)
        return subscription
    }
    
    
    func subscribe (_ observer: Observer){
        print(#function)
        observers.append(observer)
    }
    
    
    func unsubscribe (_ observer: Observer){
        print(#function)
        if let index = observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    
    
    func notify() {
        print(#function)
        observers.forEach({$0.update()})
        observableObject?.objectWillChange.notify()
        
    }
}
