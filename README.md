# PirateWar

Classic 10x10 Battleship game with Pirate theme, support practice mode and single player vs 4 AI levels.

## 📦 Package Dependencies

Please double check and add those into the project. `Reset package caches` and `Update package caches` when there's any problem with packages before building the app.

- [Lottie](https://github.com/airbnb/lottie-ios)

## ⚡️ Features

- 2 game modes: **Practice** (vs random deployed fleet) and **Player vs AI** (turn-based interaction)
- Drag, Drop, and Rotate for fleet deployment on 10x10 board.
- Simple user management and ranking system with `UserDefaults`
- Background Music, Sound Effects, Animation, Haptic Manager
- 4 levels of simple AI (still working on optimization)
- Light and Dark mode supported (based on System Settings)

Since this app is built only in 2 weeks for assessment purpose under iOS Development course @RMIT University, several **further improvements** can be investigated in to make this app ready to be published:

- AI optimization
- Multiplayer (LAN / WiFi / Local)
- UI/UX (Animations, Sounds, Game Elements, Effects...)
- User Management and Ranking System.

## 📱 Screenshots (TBA)

## 🧱 Project Structure

- `./Components` store all the reusable / customized components in the project
- `./Extensions` adapt customization on development types (Color, String, Double,...)
- `./Managers` configure sounds (for background and effect) and haptic notification
- `./Models`
  - `AI`: Including 4 levels of AI
  - `Core`: Game elements
- `./Utils` support converting operation and accessing/updating UserDefaults
- `./Views` includes the main View files of the app

## 📖 Acknowledgement

- [klynch71/Battleship-SwiftUI](https://github.com/klynch71/Battleship-SwiftUI) for Practice Mode and core elements of a classic Battleship game
- [Oliver-Binns/Battleships-AI---Swift-Playground](https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground) for the first 3 levels of AI
- [DataGenetics Battleship](https://www.datagenetics.com/blog/december32011/) for overview of Battleship algorithms and AI modelling

## 🛠 Build Info

- Xcode 13.4.1
- SwiftUI
- iPhone 8 or higher screen, iPadOS, Native M1 MacOS
- Target iOS version: 15.5
