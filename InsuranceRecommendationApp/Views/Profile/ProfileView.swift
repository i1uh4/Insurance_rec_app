import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var editedUser: User?
    @State private var isEditing = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var gender = "Male"
    @State private var occupation = ""
    @State private var income = ""
    @State private var maritalStatus = "Single"
    @State private var hasChildren = false
    @State private var hasVehicle = false
    @State private var hasHome = false
    @State private var hasMedicalConditions = false
    @State private var travelFrequency = "Rarely"
    
    let genderOptions = ["Male", "Female"]
    let maritalStatusOptions = ["Single", "Married", "Divorced", "Widowed"]
    let travelFrequencyOptions = ["Rarely", "Occasionally", "Frequently"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Account Information")) {
                        LabeledContent("Username", value: authViewModel.user?.name ?? "")
                        LabeledContent("Email", value: authViewModel.user?.email ?? "")
                    }
                    
                    Section(header: Text("Personal Information")) {
                        if isEditing {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            TextField("Age", text: $age)
                                .keyboardType(.numberPad)
                            
                            Picker("Gender", selection: $gender) {
                                ForEach(genderOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            TextField("Occupation", text: $occupation)
                            TextField("Annual Income", text: $income)
                                .keyboardType(.decimalPad)
                            
                            Picker("Marital Status", selection: $maritalStatus) {
                                ForEach(maritalStatusOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        } else {
                            LabeledContent("First Name", value: authViewModel.user?.firstName ?? "Not set")
                            LabeledContent("Last Name", value: authViewModel.user?.lastName ?? "Not set")
                            LabeledContent("Age", value: authViewModel.user?.age != nil ? "\(authViewModel.user!.age!)" : "Not set")
                            LabeledContent("Gender", value: authViewModel.user?.gender ?? "Not set")
                            LabeledContent("Occupation", value: authViewModel.user?.occupation ?? "Not set")
                            LabeledContent("Annual Income", value: authViewModel.user?.income != nil ? "$\(Int(authViewModel.user!.income!))" : "Not set")
                            LabeledContent("Marital Status", value: authViewModel.user?.maritalStatus ?? "Not set")
                        }
                    }
                    
                    Section(header: Text("Additional Information")) {
                        if isEditing {
                            Toggle("Have Children", isOn: $hasChildren)
                            Toggle("Own a Vehicle", isOn: $hasVehicle)
                            Toggle("Own a Home", isOn: $hasHome)
                            Toggle("Have Medical Conditions", isOn: $hasMedicalConditions)
                            
                            Picker("Travel Frequency", selection: $travelFrequency) {
                                ForEach(travelFrequencyOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                        } else {
                            LabeledContent("Have Children", value: (authViewModel.user?.hasChildren ?? false) ? "Yes" : "No")
                            LabeledContent("Own a Vehicle", value: (authViewModel.user?.hasVehicle ?? false) ? "Yes" : "No")
                            LabeledContent("Own a Home", value: (authViewModel.user?.hasHome ?? false) ? "Yes" : "No")
                            LabeledContent("Have Medical Conditions", value: (authViewModel.user?.hasMedicalConditions ?? false) ? "Yes" : "No")
                            LabeledContent("Travel Frequency", value: authViewModel.user?.travelFrequency ?? "Not set")
                        }
                    }
                    
                    Section {
                        if isEditing {
                            Button("Save Changes") {
                                saveChanges()
                            }
                            .foregroundColor(.blue)
                            
                            Button("Cancel") {
                                isEditing = false
                            }
                            .foregroundColor(.red)
                        } else {
                            Button("Edit Profile") {
                                loadUserData()
                                isEditing = true
                            }
                            .foregroundColor(.blue)
                        }
                        
                        Button("Logout") {
                            authViewModel.logout()
                        }
                        .foregroundColor(.red)
                    }
                }
                .navigationTitle("Profile")
                .onAppear {
                    loadUserData()
                }
                
                if authViewModel.isLoading {
                    LoadingView(message: "Saving profile...")
                }
            }
            .alert(item: $authViewModel.profileAlert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text(alert.dismissButton))
                )
            }
        }
    }
    
    private func loadUserData() {
        guard let user = authViewModel.user else { return }
        
        firstName = user.firstName ?? ""
        lastName = user.lastName ?? ""
        age = user.age != nil ? "\(user.age!)" : ""
        gender = user.gender ?? "Male"
        occupation = user.occupation ?? ""
        income = user.income != nil ? "\(user.income!)" : ""
        maritalStatus = user.maritalStatus ?? "Single"
        hasChildren = user.hasChildren ?? false
        hasVehicle = user.hasVehicle ?? false
        hasHome = user.hasHome ?? false
        hasMedicalConditions = user.hasMedicalConditions ?? false
        travelFrequency = user.travelFrequency ?? "Rarely"
    }
    
    private func saveChanges() {
        guard var updatedUser = authViewModel.user else { return }
        
        updatedUser.firstName = firstName.isEmpty ? nil : firstName
        updatedUser.lastName = lastName.isEmpty ? nil : lastName
        updatedUser.age = age.isEmpty ? nil : Int(age)
        updatedUser.gender = gender
        updatedUser.occupation = occupation.isEmpty ? nil : occupation
        updatedUser.income = income.isEmpty ? nil : Double(income)
        updatedUser.maritalStatus = maritalStatus
        updatedUser.hasChildren = hasChildren
        updatedUser.hasVehicle = hasVehicle
        updatedUser.hasHome = hasHome
        updatedUser.hasMedicalConditions = hasMedicalConditions
        updatedUser.travelFrequency = travelFrequency
        
        authViewModel.updateProfile(updatedUser: updatedUser)
        isEditing = false
    }
}
