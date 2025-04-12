import SwiftUI

struct InsuranceCard: View {
    var insurance: Insurance
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(insurance.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(insurance.company)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(insurance.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Coverage")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("$\(Int(insurance.coverageAmount))")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Duration")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(insurance.duration) months")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Price")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("$\(Int(insurance.price))/mo")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
