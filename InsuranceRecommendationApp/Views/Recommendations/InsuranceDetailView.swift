import SwiftUI

struct InsuranceDetailView: View {
    var insurance: Insurance
    @State private var showingContactSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(insurance.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(insurance.company)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(insurance.category)
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(20)
                        
                        Spacer()
                        
                        Text("$\(Int(insurance.price))/month")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom)
                
                Divider()
                
                // Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("About this plan")
                        .font(.headline)
                    
                    Text(insurance.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Coverage details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Coverage Details")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Coverage Amount")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("$\(Int(insurance.coverageAmount))")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Duration")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("\(insurance.duration) months")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                Divider()
                
                // Company info
                VStack(alignment: .leading, spacing: 10) {
                    Text("Provider Information")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Company")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text(insurance.company)
                                .font(.body)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showingContactSheet = true
                        }) {
                            Text("Contact")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                Spacer(minLength: 30)
                
                // Apply button
                Button(action: {
                    showingContactSheet = true
                }) {
                    Text("Apply for this plan")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Insurance Details")
        .navigationBarTitleDisplayMode(.inline)
        .actionSheet(isPresented: $showingContactSheet) {
            ActionSheet(
                title: Text("Contact \(insurance.company)"),
                message: Text("Choose how you'd like to proceed"),
                buttons: [
                    .default(Text("Call Insurance Provider")) {
                        // Would implement actual call functionality
                    },
                    .default(Text("Email Insurance Provider")) {
                        // Would implement actual email functionality
                    },
                    .default(Text("Visit Website")) {
                        // Would implement actual website visit
                    },
                    .cancel()
                ]
            )
        }
    }
}
