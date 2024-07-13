# WaveEffectModifier

WaveEffectModifier is a SwiftUI library that provides a customizable wave effect view modifier. This library allows you to animate wave shapes within your SwiftUI views, creating visually appealing and dynamic UI elements.

![Alt text](https://i.ibb.co/zX6Mf8P/wave-ezgif-com-video-to-gif-converter.gif)

## Features

- **Customizable Waves**: Define the number of waves, their animation duration, and flexibility.
- **Animatable Control Points**: Animate the control points of the wave shape to create fluid wave movements.
- **Flexible Fill Styles**: Use any SwiftUI `ShapeStyle` to fill the wave shapes, allowing for custom colors and gradients.

## Installation

### Swift Package Manager

To integrate WaveEffectModifier into your Xcode project, follow these steps:

1. Open your project in Xcode.
2. Go to `File` > `Add Packages`.
3. Enter the package repository URL: `https://github.com/YourUsername/WaveEffectModifier.git`
4. Choose the version and add the package to your project.

## Usage

To use the wave effect in your SwiftUI views and shapes, simply apply the `waveEffect` modifier to any `View` or `Shape`.

### Basic Wave Effect with Default Settings

```swift
import SwiftUI
import WaveEffectModifier

struct BasicWaveEffectView: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack {
            Rectangle()
                .waveEffect(progress: progress)
                .frame(height: 200)
                .padding()
            
            Slider(value: $progress, in: 0...1)
                .padding()
        }
    }
}
```

### Custom Colors and Multiple Waves

```swift
import SwiftUI
import WaveEffectModifier

struct MultiWaveEffectView: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack {
            Rectangle()
                .waveEffect(
                    progress: progress,
                    wavesCount: 5,
                    animationDuration: 3.0,
                    waveFlexibility: 0.2
                ) { index in
                    Color.blue.opacity(0.2 + Double(index) * 0.15)
                }
                .frame(height: 200)
                .padding()
            
            Slider(value: $progress, in: 0...1)
                .padding()
        }
    }
}
```


### Wave Effect with Gradient Fill and Increased Flexibility

```swift
import SwiftUI
import WaveEffectModifier

struct GradientWaveEffectView: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack {
            Rectangle()
                .waveEffect(
                    progress: progress,
                    wavesCount: 3,
                    animationDuration: 2.5,
                    waveFlexibility: 0.3
                ) { _ in
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .frame(height: 200)
                .padding()
            
            Slider(value: $progress, in: 0...1)
                .padding()
        }
    }
}
```








