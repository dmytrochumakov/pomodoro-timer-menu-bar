//
//  PomodoroTimerMenuBarApp.swift
//  PomodoroTimerMenuBar
//
//  Created by Dmytro Chumakov on 21.11.2023.
//

import SwiftUI

@main
struct PomodoroTimerMenuBarApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(onShow: {}, onClose: {})
        }
    }
    
}
