# SEIAssesment

Figma App Rebuild – SwiftUI & UIKit Hybrid

Overview

This project is a hybrid iOS app I built to match a multi-screen design from Figma. The goal was to demonstrate my ability to work across both SwiftUI and UIKit using clean architecture, reusable components, and modern development patterns. I focused heavily on modularity and responsiveness, while also keeping the codebase scalable and test-friendly.

The app is split across three main screens:

Screen 1 (SwiftUI): Dashboard Built in SwiftUI with resuable DashboardSection maintaining consitency throughout the view, the view. SwiftuI Loadable views are shown based on viewModel status. Each section depending on "API" handles its own status updates - allowing data to be retrieved asynchronously and views to update independently. 

Screens 2 & 3 (UIKit): Built with UIViewController subclasses, these screens feature a structured layout MVVM architecture leveraging combine to achieve independent view updates in a very similar fasion to the SwitUI Dashboard. The combination shows similarities undienable making this project ease to extend and update by providing a clear path forward.


Architecture & Patterns

SwiftUI Patterns
Used view composition to break UIs into small, flexible components (like pill(), CourseCardView, etc.).
Managed state with @StateObject and @Published in ObservableObject view models.
Navigation is handled cleanly through a central NavigationHandler using Combine and @Published state.
SwiftUI screens are data-driven and reactive, with logic abstracted away from views.


UIKit Patterns
Followed MVVM with Combine in CourseMenuViewController, observing view model state to drive the UI.
Components like SimpleBannerView and HorizontalScrollView are modular and configured via view models.
Auto Layout is used for all UIKit layouts, with safe area constraints and padding built in.

Shared Concepts
The Loadable<T> enum is used across both platforms to handle loading, success, error, and idle states.
All data is mock-driven through protocol-based services — no external APIs required.
Architecture supports previewing, unit testing, and future extensibility.
