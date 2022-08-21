/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 19/07/2022
    Last modified: 06/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import SwiftUI
import Lottie

struct LaunchView: View {
    @State var isActive: Bool = false
    @State var opacity = 0.0

    var body: some View {
        VStack {
            if self.isActive {
                // Load main view
                HomeView()
            } else {
                ZStack {
                    // Load launch/splash view
                    LottieView(name: "pirates", loopMode: .playOnce)
                    Text("🏴‍☠️ Pirate War 📌")
                        .foregroundColor(Color.theme.primaryText).opacity(opacity)
                        .font(.title2)
                        .padding(.top, 320)
                        .onAppear {
                        // Adjust in and out opacity animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            withAnimation {
                                self.opacity = 1.0
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.opacity = 0.0
                            }
                        }
                    }
                        .padding(.bottom, 100)
                }
                    .background(Color.theme.background)
            }
        }
            .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut) {
                    self.opacity = 0.0
                    self.isActive = true
                }
            }
        }

    }

    struct LaunchView_Previews: PreviewProvider {
        static var previews: some View {
            LaunchView()
                .preferredColorScheme(.dark)
            //            .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
