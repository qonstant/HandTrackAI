
# HandTrackAI

This application was created using Swift(UIKit).

### Run

1. Clone the repository:
   ```sh
   git clone https://github.com/qonstant/HandTrackAI.git
2. Go to the "/HandTrackAI" folder and run "HandTrackAI.xcodeproj" **ON YOUR IPHONE**, since it requires camera and you can't test it on simulator:

### Introduction:

This app is designed to aid children with infantile cerebral palsy in improving their hand motor skills. Through interactive exercises and games, it assists kids in enhancing their motor functions and overall development.

### What is VNDetectHumanHandPose?

VNDetectHumanHandPose is an iOS feature that uses the Vision framework to detect and track human hand poses in images and live video streams, enabling developers to create apps with gesture recognition and hand tracking capabilities.

<img width="1470" alt="Hand Pose " src="https://github.com/qonstant/HandTrackAI/assets/98641240/667dc7d9-22ef-4503-a070-5d353c10df5a">

### Hose to use this App?

The app consists of two sections: one for AR Painting and the other for Finger Tracking.

<img width="352" alt="menu" src="https://github.com/qonstant/HandTrackAI/assets/98641240/c3868a04-0261-4e82-b9c8-26a67a3bc146">

When saving a position of key points, you will need to press a specific key along with its corresponding ID. Consequently, the ID will be stored in the first column, while the coordinates of the keypoints will be stored in subsequent columns.

The application hierarchy looks like this

<img width="614" alt="Storyboard" src="https://github.com/qonstant/HandTrackAI/assets/98641240/e1218198-f938-490f-9087-eabb9334c1b2">


### How does it work?

We are just simply creating request of the current hand position

```swift
private var handPoseRequest = VNDetectHumanHandPoseRequest()
```

After which we are getting coordinates of each finger

```swift
let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])
        do {
            let startTime = CFAbsoluteTimeGetCurrent()
            // Perform VNDetectHumanHandPoseRequest
            try handler.perform([handPoseRequest])
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            guard let observation = handPoseRequest.results?.first else {
                cameraView.showPoints([])
                return
            }
            // Get points for all fingers
            let thumbPoints = try observation.recognizedPoints(VNHumanHandPoseObservation.JointsGroupName.thumb)
            let indexFingerPoints = try observation.recognizedPoints(VNHumanHandPoseObservation.JointsGroupName.indexFinger)
            let middleFingerPoints = try observation.recognizedPoints(VNHumanHandPoseObservation.JointsGroupName.middleFinger)
            let ringFingerPoints = try observation.recognizedPoints(VNHumanHandPoseObservation.JointsGroupName.ringFinger)
            let littleFingerPoints = try observation.recognizedPoints(VNHumanHandPoseObservation.JointsGroupName.littleFinger)
            let wristPoint = try observation.recognizedPoint(VNHumanHandPoseObservation.JointName.wrist)
                    
            // Look for tip points.
            guard let thumbTipPoint = thumbPoints[.thumbTip],
                  let thumbIpPoint = thumbPoints[.thumbIP],
                  let thumbMpPoint = thumbPoints[.thumbMP],
                  let thumbCmcPoint = thumbPoints[.thumbCMC],
                  let indexTipPoint = indexFingerPoints[.indexTip],
                  let indexDipPoint = indexFingerPoints[.indexDIP],
                  let indexPipPoint = indexFingerPoints[.indexPIP],
                  let indexMcpPoint = indexFingerPoints[.indexMCP],
                  let middleTipPoint = middleFingerPoints[.middleTip],
                  let middleDipPoint = middleFingerPoints[.middleDIP],
                  let middlePipPoint = middleFingerPoints[.middlePIP],
                  let middleMcpPoint = middleFingerPoints[.middleMCP],
                  let ringTipPoint = ringFingerPoints[.ringTip],
                  let ringDipPoint = ringFingerPoints[.ringDIP],
                  let ringPipPoint = ringFingerPoints[.ringPIP],
                  let ringMcpPoint = ringFingerPoints[.ringMCP],
                  let littleTipPoint = littleFingerPoints[.littleTip],
                  let littleDipPoint = littleFingerPoints[.littleDIP],
                  let littlePipPoint = littleFingerPoints[.littlePIP],
                  let littleMcpPoint = littleFingerPoints[.littleMCP] else {
            cameraView.showPoints([])
            return
        }
    }
```

We have threshold value of 30%, which will only show points only when confidence level is more than 30%. 

After getting coordinates of points from Vision we are converting them to AVFoundation format.

```swift
thumbTip = CGPoint(x: thumbTipPoint.location.x, y: 1 - thumbTipPoint.location.y)
thumbIp = CGPoint(x: thumbIpPoint.location.x, y: 1 - thumbIpPoint.location.y)
thumbMp = CGPoint(x: thumbMpPoint.location.x, y: 1 - thumbMpPoint.location.y)
thumbCmc = CGPoint(x: thumbCmcPoint.location.x, y: 1 - thumbCmcPoint.location.y)
indexTip = CGPoint(x: indexTipPoint.location.x, y: 1 - indexTipPoint.location.y)
indexDip = CGPoint(x: indexDipPoint.location.x, y: 1 - indexDipPoint.location.y)
indexPip = CGPoint(x: indexPipPoint.location.x, y: 1 - indexPipPoint.location.y)
indexMcp = CGPoint(x: indexMcpPoint.location.x, y: 1 - indexMcpPoint.location.y)
middleTip = CGPoint(x: middleTipPoint.location.x, y: 1 - middleTipPoint.location.y)
middleDip = CGPoint(x: middleDipPoint.location.x, y: 1 - middleDipPoint.location.y)
middlePip = CGPoint(x: middlePipPoint.location.x, y: 1 - middlePipPoint.location.y)
middleMcp = CGPoint(x: middleMcpPoint.location.x, y: 1 - middleMcpPoint.location.y)
ringTip = CGPoint(x: ringTipPoint.location.x, y: 1 - ringTipPoint.location.y)
ringDip = CGPoint(x: ringDipPoint.location.x, y: 1 - ringDipPoint.location.y)
ringPip = CGPoint(x: ringPipPoint.location.x, y: 1 - ringPipPoint.location.y)
ringMcp = CGPoint(x: ringMcpPoint.location.x, y: 1 - ringMcpPoint.location.y)
littleTip = CGPoint(x: littleTipPoint.location.x, y: 1 - littleTipPoint.location.y)
littleDip = CGPoint(x: littleDipPoint.location.x, y: 1 - littleDipPoint.location.y)
littlePip = CGPoint(x: littlePipPoint.location.x, y: 1 - littlePipPoint.location.y)
littleMcp = CGPoint(x: littleMcpPoint.location.x, y: 1 - littleMcpPoint.location.y)
wrist = CGPoint(x: wristPoint.location.x, y: 1 - wristPoint.location.y)
```

### How does it look like?

The first section, featuring AR Painting, looks like the GIF below.

![AR](https://github.com/qonstant/HandTrackAI/assets/98641240/2a9fbb7c-5854-4c91-9a52-bfb6dfedacb5)


The second section, featuring Hand Tracking, looks like the image below.

<img width="356" alt="hand" src="https://github.com/qonstant/HandTrackAI/assets/98641240/8b39a7ab-ca4d-4056-879d-1eae9ccd1728">
