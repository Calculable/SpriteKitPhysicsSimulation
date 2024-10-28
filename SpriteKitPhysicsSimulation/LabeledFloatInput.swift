import SwiftUI

struct LabeledFloatInput: View {
    // Binding to a Float value
    @Binding var value: Float
    
    // Single text parameter for both label and placeholder
    var text: String

    var body: some View {
        LabeledContent {
            TextField(value: $value, format: .number) {
                Text(text)
            }
            .multilineTextAlignment(.trailing)
            .keyboardType(.decimalPad)
        } label: {
            Text(text)
        }
    }
}
