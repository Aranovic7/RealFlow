import SwiftUI

struct LanguageSettings: View {
    
    @State private var selectedLanguageIndex = 0
    
    let languages = ["🇬🇧 English", "🇪🇸 Espanol", "🇸🇪 Svenska", "🇫🇷 France", "🇩🇪 Deutsch"]
    
    var body: some View {
        List {
            Picker("Select a language", selection: $selectedLanguageIndex) {
                ForEach(0..<languages.count) { index in
                    Text(languages[index])
                        .tag(index)
                }
            }
            .pickerStyle(.inline)
            .padding()
        }
    }
}

#Preview {
    LanguageSettings()
}

