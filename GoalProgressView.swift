import SwiftUI
import Charts

struct GoalProgressView: View {
    @Binding var progressData: [Double]
    @Binding var sleepData: [Double] // New binding for sleep data
    @State private var goal: Double = UserDefaults.standard.double(forKey: "userGoal") // Load saved goal

    var body: some View {
        VStack {
            Text("Goal Progress")
                .font(.headline)
                .padding()

            ProgressView(value: progressData.last ?? 0, total: goal)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            // Goal customization
            Text("Set Your Goal")
                .font(.headline)
                .padding()
            HStack {
                TextField("Enter goal", value: $goal, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    // Save goal logic
                    saveGoal()
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }

            // Historical data visualization
            Text("Historical Progress")
                .font(.headline)
                .padding()
            LineChartView(data: progressData, title: "Progress Over Time", legend: "Points")

            // Trend analysis
            Text("Trend Analysis")
                .font(.headline)
                .padding()
            TrendChartView(data: progressData, title: "Trend Over Time", legend: "Points")

            // Goal achievement milestones
            Text("Milestones")
                .font(.headline)
                .padding()
            MilestoneView(progress: progressData.last ?? 0, goal: goal)

            // Detailed statistics
            Text("Statistics")
                .font(.headline)
                .padding()
            HStack {
                VStack {
                    Text("Average")
                    Text("\(average(of: progressData), specifier: "%.2f")")
                }
                .padding()
                VStack {
                    Text("Min")
                    Text("\(progressData.min() ?? 0, specifier: "%.2f")")
                }
                .padding()
                VStack {
                    Text("Max")
                    Text("\(progressData.max() ?? 0, specifier: "%.2f")")
                }
                .padding()
            }

            // Comparative analysis
            Text("Comparative Analysis")
                .font(.headline)
                .padding()
            ComparativeChartView(currentData: progressData, previousData: Array(progressData.prefix(progressData.count - 1)), title: "Current vs Previous Progress", legend: "Points")

            // New section for sleep tracking
            Text("Sleep Tracking")
                .font(.headline)
                .padding()

            if sleepData.isEmpty {
                Text("No sleep data available. Set up timers and alarms for sleep tracking.")
                    .font(.subheadline)
                    .padding()
            } else {
                ProgressView(value: sleepData.last ?? 0, total: 8) // Assuming 8 hours as the goal
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                Text("Last night's sleep: \(sleepData.last ?? 0, specifier: "%.1f") hours")
                    .font(.subheadline)
                    .padding()

                // Historical sleep data visualization
                Text("Historical Sleep Data")
                    .font(.headline)
                    .padding()
                LineChartView(data: sleepData, title: "Sleep Over Time", legend: "Hours")

                // Detailed sleep statistics
                Text("Sleep Statistics")
                    .font(.headline)
                    .padding()
                HStack {
                    VStack {
                        Text("Average")
                        Text("\(average(of: sleepData), specifier: "%.2f")")
                    }
                    .padding()
                    VStack {
                        Text("Min")
                        Text("\(sleepData.min() ?? 0, specifier: "%.2f")")
                    }
                    .padding()
                    VStack {
                        Text("Max")
                        Text("\(sleepData.max() ?? 0, specifier: "%.2f")")
                    }
                    .padding()
                }

                // Comparative sleep analysis
                Text("Comparative Sleep Analysis")
                    .font(.headline)
                    .padding()
                ComparativeChartView(currentData: sleepData, previousData: Array(sleepData.prefix(sleepData.count - 1)), title: "Current vs Previous Sleep", legend: "Hours")
            }
        }
    }

    private func saveGoal() {
        // Logic to save the goal
        // This could involve saving to UserDefaults, a database, or some other storage
        UserDefaults.standard.set(goal, forKey: "userGoal")
    }

    private func average(of data: [Double]) -> Double {
        guard !data.isEmpty else { return 0 }
        return data.reduce(0, +) / Double(data.count)
    }
}

struct LineChartView: View {
    var data: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Value", value)
                )
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}

struct ComparativeChartView: View {
    var currentData: [Double]
    var previousData: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(currentData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Current", value)
                )
                .foregroundStyle(Color.blue)
            }
            ForEach(Array(previousData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Previous", value)
                )
                .foregroundStyle(Color.gray)
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}

struct TrendChartView: View {
    var data: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Value", value)
                )
                .interpolationMethod(.catmullRom)
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}

struct MilestoneView: View {
    var progress: Double
    var goal: Double

    var body: some View {
        VStack {
            if progress >= goal * 0.10 {
                MilestoneIndicator(progress: progress, goal: goal, milestone: 0.10, color: .red)
            }
            if progress >= goal * 0.25 {
                MilestoneIndicator(progress: progress, goal: goal, milestone: 0.25, color: .orange)
            }
            if progress >= goal * 0.50 {
                MilestoneIndicator(progress: progress, goal: goal, milestone: 0.50, color: .yellow)
            }
            if progress >= goal * 0.75 {
                MilestoneIndicator(progress: progress, goal: goal, milestone: 0.75, color: .green)
            }
            if progress >= goal {
                MilestoneIndicator(progress: progress, goal: goal, milestone: 1.0, color: .blue)
            }
        }
    }
}

struct MilestoneIndicator: View {
    var progress: Double
    var goal: Double
    var milestone: Double
    var color: Color

    var body: some View {
        VStack {
            Text("🎉 \(Int(milestone * 100))% of your goal achieved!")
                .font(.headline)
                .padding()
            ProgressView(value: progress / goal, total: milestone)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
                .padding()
                .animation(.easeInOut(duration: 1.0), value: progress)
        }
    }
}
struct YearOverYearChartView: View {
    var currentYearData: [Double]
    var previousYearData: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(currentYearData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Month", index),
                    y: .value("Current Year", value)
                )
                .foregroundStyle(Color.blue)
            }
            ForEach(Array(previousYearData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Month", index),
                    y: .value("Previous Year", value)
                )
                .foregroundStyle(Color.gray)
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}
VStack {
    // Other views...

    // Year-over-year comparison for progress data
    Text("Year-over-Year Progress Comparison")
        .font(.headline)
        .padding()
    YearOverYearChartView(
        currentYearData: currentYearProgressData,
        previousYearData: previousYearProgressData,
        title: "Year-over-Year Progress",
        legend: "Points"
    )

    // Year-over-year comparison for sleep data
    Text("Year-over-Year Sleep Comparison")
        .font(.headline)
        .padding()
    YearOverYearChartView(
        currentYearData: currentYearSleepData,
        previousYearData: previousYearSleepData,
        title: "Year-over-Year Sleep",
        legend: "Hours"
    )

    // Other views...
}
struct MonthOverMonthChartView: View {
    var currentMonthData: [Double]
    var previousMonthData: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(currentMonthData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Current Month", value)
                )
                .foregroundStyle(Color.blue)
            }
            ForEach(Array(previousMonthData.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Previous Month", value)
                )
                .foregroundStyle(Color.gray)
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}
VStack {
    // Other views...

    // Month-over-month comparison for progress data
    Text("Month-over-Month Progress Comparison")
        .font(.headline)
        .padding()
    MonthOverMonthChartView(
        currentMonthData: currentMonthProgressData,
        previousMonthData: previousMonthProgressData,
        title: "Month-over-Month Progress",
        legend: "Points"
    )

    // Month-over-month comparison for sleep data
    Text("Month-over-Month Sleep Comparison")
        .font(.headline)
        .padding()
    MonthOverMonthChartView(
        currentMonthData: currentMonthSleepData,
        previousMonthData: previousMonthSleepData,
        title: "Month-over-Month Sleep",
        legend: "Hours"
    )

    // Other views...
}
// Example data for progress and sleep
let progressData: [Double] = [/* Your progress data */]
let sleepData: [Double] = [/* Your sleep data */]

// Split data into current and previous year/month
let currentYearProgressData = Array(progressData.suffix(12)) // Last 12 months
let previousYearProgressData = Array(progressData.prefix(progressData.count - 12).suffix(12)) // Previous 12 months

let currentMonthProgressData = Array(progressData.suffix(30)) // Last 30 days
let previousMonthProgressData = Array(progressData.prefix(progressData.count - 30).suffix(30)) // Previous 30 days

let currentYearSleepData = Array(sleepData.suffix(12)) // Last 12 months
let previousYearSleepData = Array(sleepData.prefix(sleepData.count - 12).suffix(12)) // Previous 12 months

let currentMonthSleepData = Array(sleepData.suffix(30)) // Last 30 days
let previousMonthSleepData = Array(sleepData.prefix(sleepData.count - 30).suffix(30)) // Previous 30 days
struct GoalProgressView: View {
    @Binding var progressData: [Double]
    @Binding var sleepData: [Double]
    @State private var goal: Double = UserDefaults.standard.double(forKey: "userGoal")

    var body: some View {
        VStack {
            // Other views...

            // Year-over-year comparison for progress data
            Text("Year-over-Year Progress Comparison")
                .font(.headline)
                .padding()
            YearOverYearChartView(
                currentYearData: Array(progressData.suffix(12)),
                previousYearData: Array(progressData.prefix(progressData.count - 12).suffix(12)),
                title: "Year-over-Year Progress",
                legend: "Points"
            )

            // Year-over-year comparison for sleep data
            Text("Year-over-Year Sleep Comparison")
                .font(.headline)
                .padding()
            YearOverYearChartView(
                currentYearData: Array(sleepData.suffix(12)),
                previousYearData: Array(sleepData.prefix(sleepData.count - 12).suffix(12)),
                title: "Year-over-Year Sleep",
                legend: "Hours"
            )

            // Month-over-month comparison for progress data
            Text("Month-over-Month Progress Comparison")
                .font(.headline)
                .padding()
            MonthOverMonthChartView(
                currentMonthData: Array(progressData.suffix(30)),
                previousMonthData: Array(progressData.prefix(progressData.count - 30).suffix(30)),
                title: "Month-over-Month Progress",
                legend: "Points"
            )

            // Month-over-month comparison for sleep data
            Text("Month-over-Month Sleep Comparison")
                .font(.headline)
                .padding()
            MonthOverMonthChartView(
                currentMonthData: Array(sleepData.suffix(30)),
                previousMonthData: Array(sleepData.prefix(sleepData.count - 30).suffix(30)),
                title: "Month-over-Month Sleep",
                legend: "Hours"
            )

            // Other views...
        }
    }
}
import Accelerate

func linearRegression(_ data: [Double]) -> (slope: Double, intercept: Double)? {
    guard data.count > 1 else { return nil }
    
    let n = Double(data.count)
    let sumX = n * (n - 1) / 2
    let sumY = data.reduce(0, +)
    let sumXY = data.enumerated().reduce(0) { $0 + Double($1.offset) * $1.element }
    let sumX2 = (n - 1) * n * (2 * n - 1) / 6
    
    let slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
    let intercept = (sumY - slope * sumX) / n
    
    return (slope, intercept)
}

func predictNextValues(data: [Double], count: Int) -> [Double] {
    guard let (slope, intercept) = linearRegression(data) else { return [] }
    
    let startIndex = data.count
    return (0..<count).map { Double(startIndex + $0) * slope + intercept }
}
struct GoalProgressView: View {
    @Binding var progressData: [Double]
    @Binding var sleepData: [Double]
    @State private var goal: Double = UserDefaults.standard.double(forKey: "userGoal")
    
    var body: some View {
        VStack {
            // Other views...

            // Predictive analytics for progress data
            Text("Predicted Progress")
                .font(.headline)
                .padding()
            LineChartView(
                data: progressData + predictNextValues(data: progressData, count: 7),
                title: "Progress Prediction",
                legend: "Points"
            )

            // Predictive analytics for sleep data
            Text("Predicted Sleep")
                .font(.headline)
                .padding()
            LineChartView(
                data: sleepData + predictNextValues(data: sleepData, count: 7),
                title: "Sleep Prediction",
                legend: "Hours"
            )

            // Other views...
        }
    }
}
// Example data for progress and sleep
let progressData: [Double] = [/* Your progress data */]
let sleepData: [Double] = [/* Your sleep data */]

// Predict next 7 days of progress and sleep
let predictedProgressData = predictNextValues(data: progressData, count: 7)
let predictedSleepData = predictNextValues(data: sleepData, count: 7)
struct LineChartView: View {
    var data: [Double]
    var title: String
    var legend: String

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Day", index),
                    y: .value("Value", value)
                )
                .foregroundStyle(index < data.count - 7 ? Color.blue : Color.red)
            }
        }
        .chartTitle(Text(title))
        .chartLegend(Text(legend))
        .frame(height: 200)
        .padding()
    }
}
struct GoalProgressView: View {
    @Binding var progressData: [Double]
    @Binding var sleepData: [Double]
    @State private var goal: Double = UserDefaults.standard.double(forKey: "userGoal")

    var body: some View {
        VStack {
            // Other views...

            // Predictive analytics for progress data
            Text("Predicted Progress")
                .font(.headline)
                .padding()
            LineChartView(
                data: progressData + predictNextValues(data: progressData, count: 7),
                title: "Progress Prediction",
                legend: "Points"
            )

            // Predictive analytics for sleep data
            Text("Predicted Sleep")
                .font(.headline)
                .padding()
            LineChartView(
                data: sleepData + predictNextValues(data: sleepData, count: 7),
                title: "Sleep Prediction",
                legend: "Hours"
            )

            // Other views...
        }
    }
}
