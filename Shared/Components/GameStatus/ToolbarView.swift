//
//  ToolbarView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var game: Game
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    
    @State var timer: Timer? = nil

    var body: some View {
        VStack {
//            HStack {
//                Button(action: { presentationMode.wrappedValue.dismiss() }) { Image(systemName: "arrow.backward.square") }
//                    .help("Back to Home.")
//                    .foregroundColor(.accentColor)
//                    .padding(.leading, 10)
//                Spacer()
//                Text(game.message)
//                Spacer()
//                Button(action: reset) { Image(systemName: "repeat") }
//                    .help("Start a new game.")
//                    .foregroundColor(.accentColor)
//                    .padding(.leading, 10)
//            }.frame(height: 30)
            
            Text("Time elapsed: \(hours):\(minutes):\(seconds)")
                .onChange(of: game.over) { newValue in
                    stopTimer()
                }
        }
        .onAppear {
            startTimer()
        }
    }

    func reset() {
        game.reset()
        restartTimer()
        startTimer()
    }
    
    func startTimer(){
      timerIsPaused = false
      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
        if self.seconds == 59 {
          self.seconds = 0
          if self.minutes == 59 {
            self.minutes = 0
            self.hours = self.hours + 1
          } else {
            self.minutes = self.minutes + 1
          }
        } else {
          self.seconds = self.seconds + 1
        }
      }
    }
    
    func stopTimer(){
      timerIsPaused = true
      timer?.invalidate()
      timer = nil
    }
    
    func restartTimer(){
      hours = 0
      minutes = 0
      seconds = 0
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
            .environmentObject(Game())
            
    }
}
