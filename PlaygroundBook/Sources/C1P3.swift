//
//  C1P3.swift
//  PlaygroundBook
//
//  Created by Arthur  Braga on 18/03/19.
//
//
//
//import UIKit
//import SceneKit
//import PlaygroundSupport
////
////
////@objc(C1P3)
////public class C1P3: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
////
////    /*
////     public func liveViewMessageConnectionOpened() {
////     // Implement this method to be notified when the live view message connection is opened.
////     // The connection will be opened when the process running Contents.swift starts running and listening for messages.
////     }
////     */
////    
////    
////    /*
////     public func liveViewMessageConnectionClosed() {
////     // Implement this method to be notified when the live view message connection is closed.
////     // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
////     // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
////     }
////     */
////    
////    public func receive(_ message: PlaygroundValue) {
////        // Implement this method to receive messages sent from the process running Contents.swift.
////        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
////        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
////    }
////}
////
////extension Date {
////    var millisecondsSince1970:Int {
////        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
////    }
////    
////    init(milliseconds:Int) {
////        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
////    }
////}
