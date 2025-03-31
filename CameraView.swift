import SwiftUI
import AVFoundation

struct CameraView: View {
    var onScanComplete: (Double) -> Void

    var body: some View {
        VStack {
            Text("Want a custom option?")
                .font(.title)
                .padding()
            
            Button(action: {
                // Simulate scanning a food item and returning a calorie value
                let scannedCalories = Double.random(in: 50...500)
                onScanComplete(scannedCalories)
            }) {
                VStack {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("Scan Food")
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView { _ in }
    }
}
struct LoadingAnimationView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Image("billy_running")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear {
                    self.isAnimating = true
                }
            Text("Analyzing...")
                .font(.headline)
                .padding()
        }
    }
}
struct FoodDetailsView: View {
    var foodName: String
    var recipe: String
    var calories: Double
    var progress: Double
    var goal: Double
    var onEat: () -> Void

    var body: some View {
        VStack {
            Text(foodName)
                .font(.largeTitle)
                .padding()

            Text("Recipe")
                .font(.headline)
                .padding(.top)
            Text(recipe)
                .padding()

            Text("Calories: \(calories, specifier: "%.0f")")
                .font(.headline)
                .padding(.top)

            Text("Progress: \(progress, specifier: "%.0f") / \(goal, specifier: "%.0f")")
                .font(.headline)
                .padding(.top)

            Button(action: onEat) {
                Text("Eat")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
    }
}
struct CameraView: View {
    @State private var isLoading = false
    @State private var foodDetails: (name: String, recipe: String, calories: Double, progress: Double)?
    var onScanComplete: (Double) -> Void

    var body: some View {
        VStack {
            if isLoading {
                LoadingAnimationView()
            } else if let details = foodDetails {
                FoodDetailsView(
                    foodName: details.name,
                    recipe: details.recipe,
                    calories: details.calories,
                    progress: details.progress,
                    goal: 2000.0, // Example goal
                    onEat: handleEat
                )
            } else {
                // Camera scanning UI
                Text("Scan your food")
                    .font(.headline)
                    .padding()
                Button(action: startScanning) {
                    Text("Start Scanning")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func startScanning() {
        isLoading = true
        // Simulate scanning and analyzing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Example food details
            foodDetails = (
                name: "Grilled Chicken",
                recipe: "1. Season the chicken.\n2. Grill the chicken.\n3. Serve with vegetables.",
                calories: 300,
                progress: 1500
            )
            isLoading = false
        }
    }

    private func handleEat() {
        // Trigger shaking screen effect and chomping sound effect
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

        let soundEffect = ["chomp1", "chomp2", "chomp3"].randomElement()!
        playSound(named: soundEffect)

        // Update progress data
        onScanComplete(foodDetails?.calories ?? 0)
    }

    private func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}
struct CameraView: View {
    @State private var isLoading = false
    @State private var foodDetails: (name: String, recipe: String, calories: Double, progress: Double)?
    var onScanComplete: (Double) -> Void

    var body: some View {
        VStack {
            if isLoading {
                LoadingAnimationView()
            } else if let details = foodDetails {
                FoodDetailsView(
                    foodName: details.name,
                    recipe: details.recipe,
                    calories: details.calories,
                    progress: details.progress,
                    goal: 2000.0, // Example goal
                    onEat: handleEat
                )
            } else {
                // Camera scanning UI
                Text("Scan your food")
                    .font(.headline)
                    .padding()
                Button(action: startScanning) {
                    Text("Start Scanning")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func startScanning() {
        isLoading = true
        // Simulate scanning and analyzing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Example food details
            foodDetails = (
                name: "Grilled Chicken",
                recipe: "1. Season the chicken.\n2. Grill the chicken.\n3. Serve with vegetables.",
                calories: 300,
                progress: 1500
            )
            isLoading = false
        }
    }

    private func handleEat() {
        // Trigger shaking screen effect and chomping sound effect
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

        let soundEffect = ["chomp1", "chomp2", "chomp3"].randomElement()!
        playSound(named: soundEffect)

        // Update progress data
        onScanComplete(foodDetails?.calories ?? 0)
    }

    private func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}
import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    @State private var isLoading = false
    @State private var foodDetails: (name: String, recipe: String, calories: Double, progress: Double)?
    var onScanComplete: (Double) -> Void

    func makeUIViewController(context: Context) -> CameraViewController {
        let viewController = CameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CameraViewControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func didRecognizeFood(name: String) {
            // Simulate fetching food details based on recognized food name
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let details = (
                    name: name,
                    recipe: "1. Prepare the ingredients.\n2. Cook the food.\n3. Serve and enjoy.",
                    calories: Double.random(in: 200...500),
                    progress: Double.random(in: 1000...2000)
                )
                self.parent.foodDetails = details
                self.parent.isLoading = false
            }
        }
    }
}

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var delegate: CameraViewControllerDelegate?
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if (captureSession.canAddOutput(videoOutput)) {
            captureSession.addOutput(videoOutput)
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let uiImage = UIImage(ciImage: ciImage)

        // Process the image to recognize predefined food items
        recognizeFood(in: uiImage)
    }

    private func recognizeFood(in image: UIImage) {
        // Simulate recognizing predefined food items
        // In a real implementation, you would use image processing techniques to recognize food items
        let recognizedFood = ["Apple", "Banana", "Orange"].randomElement()!
        delegate?.didRecognizeFood(name: recognizedFood)
    }
}

protocol CameraViewControllerDelegate {
    func didRecognizeFood(name: String)
}
struct CameraView: View {
    @State private var isLoading = false
    @State private var foodDetails: (name: String, recipe: String, calories: Double, progress: Double)?
    var onScanComplete: (Double) -> Void

    var body: some View {
        VStack {
            if isLoading {
                LoadingAnimationView()
            } else if let details = foodDetails {
                FoodDetailsView(
                    foodName: details.name,
                    recipe: details.recipe,
                    calories: details.calories,
                    progress: details.progress,
                    goal: 2000.0, // Example goal
                    onEat: handleEat
                )
            } else {
                // Camera scanning UI
                Text("Scan your food")
                    .font(.headline)
                    .padding()
                Button(action: startScanning) {
                    Text("Start Scanning")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func startScanning() {
        isLoading = true
        // Simulate scanning and analyzing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Example food details
            foodDetails = (
                name: "Grilled Chicken",
                recipe: "1. Season the chicken.\n2. Grill the chicken.\n3. Serve with vegetables.",
                calories: 300,
                progress: 1500
            )
            isLoading = false
        }
    }

    private func handleEat() {
        // Trigger shaking screen effect and chomping sound effect
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()

        let soundEffect = ["chomp1", "chomp2", "chomp3"].randomElement()!
        playSound(named: soundEffect)

        // Update progress data
        onScanComplete(foodDetails?.calories ?? 0)
    }

    private func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}


