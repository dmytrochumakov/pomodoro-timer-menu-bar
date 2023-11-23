//
//  ContentView.swift
//  PomodoroTimerMenuBar
//
//  Created by Dmytro Chumakov on 21.11.2023.
//

import SwiftUI
import Combine

enum TimerType {

    case work
    case relax

    var timeRemaining: Int {
        switch self {
        case .work:
            1500
        case .relax:
            300
        }
    }

}

struct ContentView: View {

    @State private var timeRemaining = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var connectedTimer: Cancellable? = nil
    @State private var numberOfFinishedPomodories = 0
    @State private var timerType: TimerType? = nil

    let onShow: () -> Void
    let onClose: () -> Void

    var body: some View {
        VStack {
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        if timerType == .work {
                            numberOfFinishedPomodories += 1
                        }
                        cancelTimer()
                        onShow()
                    }
                }
            Text("Pomodories: \(numberOfFinishedPomodories)")
            Button("work") {
                instantiateTimer(.work)
            }
            Button("relax") {
                instantiateTimer(.relax)
            }
        }
        .padding(16)
    }

}

private extension ContentView {

    func instantiateTimer(_ timerType: TimerType) {
        self.timerType = timerType
        self.timeRemaining = timerType.timeRemaining
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        onClose()
    }

    func cancelTimer() {
        self.connectedTimer?.cancel()
    }

}

#Preview {
    ContentView(onShow: {}, onClose: {})
}
