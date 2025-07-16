import SwiftUI
import CoreLocation

struct AddMemoryView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: MemoryViewModel
    var location: CLLocationCoordinate2D

    @State private var title: String = ""
    @State private var note: String = ""
    @State private var rating: Int = 2
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("📍 Location")) {
                    Text("Lat: \(String(format: "%.4f", location.latitude)), Lon: \(String(format: "%.4f", location.longitude))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section(header: Text("📝 Memory Details")) {
                    TextField("Enter title", text: $title)
                    TextField("Enter note", text: $note)
                }

                Section(header: Text("⭐️ Rating")) {
                    Picker("Rating", selection: $rating) {
                        ForEach(1...5, id: \.self) { i in
                            Text("\(i) ⭐️").tag(i)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("📷 Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    } else {
                        Button("Pick Image") {
                            showImagePicker = true
                        }
                    }
                }

                Section {
                    Button("✅ Save Memory") {
                        saveMemory()
                    }
                    .disabled(title.isEmpty || image == nil)
                }
            }
            .navigationTitle("Add Memory")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }

    // MARK: - Save Logic
    func saveMemory() {
        guard let image = image,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let newMemory = MemoryModel(
            id: UUID(),
            title: title,
            date: Date(),
            coordinate: CoordinateCodable(from: location),
            note: note,
            imageData: imageData,
            rating: rating
        )

        viewModel.addMemory(newMemory)
        dismiss()
    }
}
#Preview {
    AddMemoryView(viewModel: MemoryViewModel(), location: CLLocationCoordinate2D(latitude: 33.6844, longitude: 73.0479))
}
