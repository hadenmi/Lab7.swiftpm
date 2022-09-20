import SwiftUI

class Observer: ObservableObject {
    @Published var animal: String;
    @Published var color: String;
    
    init() {
        animal = "";
        color = "";
    }
    
    func SetAnimal(value: String) {
        animal = value;
    }
    
    func SetColor(value: String) {
        color = value;
    }
    
    func GetAnimal() -> String {
        return animal;
    }
    
    func GetColor() -> String {
        return color;
    }
}

struct ContentView: View {
    enum Color: String, CaseIterable, Identifiable {
        case red, orange, yellow, green, blue, purple, pink, black, white, brown
        var id: Self {
            self
        }
    }
    
    @StateObject var observer: Observer = Observer();
    
    @State var animal: String = "";
    @State var color: Color = Color.red;
    @State var submitted: Bool = false;
    
    var body: some View {
        VStack {
            if (submitted) {
                ResultsView(observer: observer)
            }
            else {
                Text("What is your favorite animal?")
                TextField("What is your favorite animal?", text: $animal);
                Text("What is your favorite color?")
                Picker("What is your favorite color?", selection: $color) {
                    Text("Red").tag(Color.red)
                    Text("Orange").tag(Color.orange)
                    Text("Yellow").tag(Color.yellow)
                    Text("Green").tag(Color.green)
                    Text("Blue").tag(Color.blue)
                    Text("Purple").tag(Color.purple)
                    Text("Black").tag(Color.black)
                    Text("White").tag(Color.white)
                    Text("Brown").tag(Color.brown)
                }
                Button("Submit") {
                    observer.SetAnimal(value: animal);
                    observer.SetColor(value: color.rawValue);
                    submitted = true;
                }
            }
        }
    }
}

struct ResultsView: View {
    @StateObject var observer: Observer;
    
    var body: some View {
        VStack {
            Text("Your response:")
            Text("Favorite animal: \(observer.GetAnimal())")
            Text("Favorite color: \(observer.GetColor())")
        }
    }
}
