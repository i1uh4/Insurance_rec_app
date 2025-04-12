import SwiftUI

struct RecommendationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = RecommendationViewModel()
    @State private var selectedCategory: String? = nil
    
    var filteredRecommendations: [Insurance] {
        if let category = selectedCategory {
            return viewModel.recommendations.filter { $0.category == category }
        }
        return viewModel.recommendations
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Getting your recommendations...")
                            .padding()
                    } else if viewModel.recommendations.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 70))
                                .foregroundColor(.blue)
                            
                            Text("Get personalized insurance recommendations based on your profile")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            CustomButton(
                                title: "Get Recommendations",
                                action: {
                                    if let user = authViewModel.user {
                                        viewModel.getRecommendations(for: user)
                                    }
                                }
                            )
                        }
                        .padding()
                    } else {
                        // Category filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                CategoryButton(
                                    title: "All",
                                    isSelected: selectedCategory == nil,
                                    action: { selectedCategory = nil }
                                )
                                
                                ForEach(insuranceCategories) { category in
                                    CategoryButton(
                                        title: category.name,
                                        icon: category.icon,
                                        isSelected: selectedCategory == category.name,
                                        action: { selectedCategory = category.name }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 10)
                        
                        // Recommendations list
                        if filteredRecommendations.isEmpty {
                            VStack(spacing: 20) {
                                Text("No recommendations found for this category")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                    .padding()
                                
                                Button("Show All") {
                                    selectedCategory = nil
                                }
                                .font(.headline)
                                .foregroundColor(.blue)
                            }
                            .padding()
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(filteredRecommendations) { insurance in
                                        NavigationLink(destination: InsuranceDetailView(insurance: insurance)) {
                                            InsuranceCard(insurance: insurance)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Recommendations")
                .onAppear {
                    // Don't automatically fetch on first appearance
                    // Let user click the button instead
                }
                
                if viewModel.isLoading {
                    LoadingView(message: "Getting recommendations...")
                }
            }
            .alert(item: $viewModel.recommendationAlert) { alert in
                Alert(
                    title: Text(alert.title),
                    message: Text(alert.message),
                    dismissButton: .default(Text(alert.dismissButton))
                )
            }
        }
    }
}

struct CategoryButton: View {
    var title: String
    var icon: String? = nil
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .bold : .regular)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(20)
        }
    }
}
