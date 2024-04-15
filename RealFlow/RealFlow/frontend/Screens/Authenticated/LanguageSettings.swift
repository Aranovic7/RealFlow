import SwiftUI

struct LanguageSettings: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Language Settings")
                .font(.title2)
            Button(action: {
                if let url = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Change Language")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.black)
            .cornerRadius(10)
        }
    }
}

#Preview {
    LanguageSettings()
}

