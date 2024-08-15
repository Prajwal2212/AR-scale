# AR Distance Measurement App Using ARKit - README
## 1. Goal
The goal of this project is to build an augmented reality (AR) app using ARKit in Swift that allows users to measure the distance between two consecutive points tapped on the screen in 3D space. The app provides an intuitive way to measure real-world distances by leveraging ARKit’s ability to detect and map the environment in real time.

## 2. Process
### 2.1. Tools and Frameworks
#### ARKit: Apple’s framework used to track and measure 3D space using the device's camera and sensors.
#### SceneKit: Utilized for rendering visual elements like lines and points within the AR experience.
#### Swift: The programming language used to develop the iOS app.
### 2.2. Steps
#### Setting Up the AR Session:

An AR session is configured using ARWorldTrackingConfiguration to track the device’s position and orientation in real time.\
The session is initialized to continually map the surrounding environment and update the device’s position relative to the world.
#### Handling User Taps:

A tap gesture recognizer is added to the view to detect when the user taps on the screen.\
Each tap captures a point in the AR scene, converted from 2D screen coordinates into a 3D world position using ARHitTestResult.
#### Storing and Displaying Points:

The 3D coordinates of the tapped points are stored in an array.\
Visual markers (such as small spheres) are added at each point to represent the selected positions.
#### Calculating Distance:

When two consecutive points are tapped, the app calculates the Euclidean distance between them using the formula:\
Distance = *((𝑥2−𝑥1)2 + (𝑦2−𝑦1)2 + (𝑧2−𝑧1)2)^1/2*\
The distance is displayed as a text label in the AR scene near the line connecting the two points.
#### Visualizing the Measurement:

A line is drawn between the two points using SceneKit to provide a clear visual indication of the measured distance.\
The distance label dynamically updates and is shown alongside the line, giving immediate feedback to the user.\
#### Resetting and Continuous Measurement:

After measuring the distance, the user can continue selecting new points or reset the measurement to start a new session.
### 2.3. Code Structure
#### ViewController.swift: Contains the core logic for handling AR sessions, detecting taps, calculating distances, and rendering visual elements like points, lines, and distance labels.
#### Main.storyboard: The interface layout where ARKit is configured and the scene is set up.
#### Assets.xcassets: Stores any additional visual assets, if used, for markers or UI elements.
## 3. Result
The final AR app allows users to measure the distance between any two points they tap on in the real world, displayed accurately in 3D space. The app uses ARKit’s world tracking and hit-testing features to determine the 3D coordinates of the tapped points and calculates the distance in real time. The measurement is visually represented with markers, lines, and dynamic labels within the AR scene.

### Key Features:
Precise measurement of real-world distances in 3D space using AR.\
Intuitive user interface with tap-to-measure functionality.\
Real-time feedback with visual lines and distance labels.\
This app demonstrates the practical application of AR for tasks like spatial measurement, offering an immersive and interactive experience that bridges the gap between the physical and digital worlds.
