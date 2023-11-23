//
//  AppDelegate.swift
//  PomodoroTimerMenuBar
//
//  Created by Dmytro Chumakov on 21.11.2023.
//

import Foundation
import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {

    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "hammer.circle.fill",
                                         accessibilityDescription: "Tool.Timer")
            statusButton.action = #selector(togglePopover)
        }
        popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(onShow: { [unowned self] in
            showPopover()
        }, onClose: { [unowned self] in
            closePopover()
        }))
    }

    @objc private func togglePopover() {
        if popover.isShown {
            closePopover()
        } else {
            showPopover()
        }
    }

    private func showPopover() {
        guard let statusButton = statusItem.button else { return }
        popover.show(relativeTo: statusButton.bounds, of: statusButton, preferredEdge: .minY)
    }

    private func closePopover() {
        popover.performClose(nil)
    }

}
