/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 09/08/2022
    Last modified: ??/??/2022
    Acknowledgement:
    - Lottie File: https://lottiefiles.com/54038-pirates
    - Lottie Tutorial: https://designcode.io/swiftui-handbook-lottie-animation
*/

import SwiftUI
import Lottie

// LottieView implement Animated Icon retrieved from Lottie JSON in the same folder
struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animation = Animation.named(name)
        animationView.animation = animation
//        animationView.animationSpeed = 2
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "pirates", loopMode: .playOnce)
//            .previewInterfaceOrientation(.landscapeRight)
    }
}
