//
//  CreateEditCardView.swift
//  Cardly
//
//  Created by urja 💙 on 2025-04-28.
//

import SwiftUI
import PhotosUI

struct CreateEditCardView: View {
    
    var card : BusinessCard? = nil
    @State private var formData = CardFormData()
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPhotoItem : PhotosPickerItem? = nil
    @State private var selectedImg : UIImage? = nil
    @State private var showingAlert = false
    @Environment(\.colorScheme) var colorScheme

   // @Query var cards : [BusinessCard]

    
    
    var body: some View {
        
        NavigationStack {
            VStack{
            ScrollView {
                VStack(spacing: 20) {
                    PhotosPicker( selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                        if let image = selectedImg {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80,height: 80)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(Color.white,lineWidth: 2)
                                }
                        }
                        else {
                            Image(systemName: "person.crop.circle.badge.plus")
                                    .font(.system(size: 80))
                                    .foregroundColor(.gray)
                        }
                    }
                    VStack(alignment: .leading, spacing: 4) {
                       // Text(card?.name ?? "uuu")
                        Text("Full Name")
                            .font(.caption)
                            .foregroundColor(formData.isNamevalid ? .black : .red)
                        TextField("Please Enter Your Name", text: $formData.name)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(formData.isNamevalid ? Color.clear : Color.red, lineWidth: 1)
                                    )
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Job Title")
                            .font(.caption)
                            .foregroundStyle(formData.isJobValid ? .black : .red)
                        TextField("Eg : Product Manager", text: $formData.jobTitle)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(formData.isJobValid ? Color.clear : Color.red, lineWidth: 1)
                                    )
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Company")
                            .font(.caption)
                            .foregroundStyle(formData.isCompanyValid ? .black : .red)
                        TextField("Eg : Google Inc.", text: $formData.company)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(formData.isCompanyValid ? Color.clear : Color.red, lineWidth: 1)
                                    )
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.caption)
                            .foregroundStyle(formData.isEmailValid ? .black : .red)
                        
                        TextField("Eg : abc@mail.com", text: $formData.email)
                            .textFieldStyle(.roundedBorder)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(formData.isEmailValid ? Color.clear : Color.red, lineWidth: 1)
                                    )
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundStyle(formData.isPhoneValid ? .black : .red)
                        TextField("+18254250918", text: $formData.phoneNumber)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(formData.isPhoneValid ? Color.clear : Color.red, lineWidth: 1)
                                    )
                    }
                    
                    ScrollView(.horizontal){
                        HStack(spacing : 8) {
                            ForEach(ColorThemeManager.cardColors,id : \.self) { colorName in
                                Circle()
                                    .fill(ColorThemeManager.NameColor[colorName] ?? .gray)
                                    .frame(width: 30, height: 30)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            formData.selectedColor = colorName
                                        }
                                    }
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black.opacity(formData.selectedColor == colorName ? 0.2 : 0), lineWidth: 2)
                                    )
                                
                            }
                            .padding(5)
                        }
                        
                    }
                    .scrollIndicators(.hidden)
                    
                    Button("Save") {
                        saveCard()
                        
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorThemeManager.accentBlue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    //.padding(.top,8)
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                )
                .padding(.horizontal,2)
                .padding(.top)
                .shadow(color: colorScheme == .dark ? .white.opacity(0.05) : .black.opacity(0.1), radius: 5, x: 0, y: 2)

                
                
                
                
            }
            .scrollIndicators(.hidden)
            .padding()
            .navigationTitle("Create Your Card")
        }
            .onAppear {
                if let card = card {
                    formData.name = card.name
                    formData.jobTitle = card.jobTitle
                    formData.company = card.company
                    formData.email = card.emailAddress
                    formData.phoneNumber = card.phoneNumber
                         formData.selectedColor = card.cardColor
         
                    if let data = card.profileImageData, let uiImg = UIImage(data: data) {
                              formData.profileImage = uiImg
                              selectedImg = uiImg
                        }
                }
            }
            .alert("Please fill all required fields", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            }
            .onChange(of: selectedPhotoItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),let uiImg = UIImage(data: data) {
                        selectedImg = uiImg
                        formData.profileImage = uiImg
                    }
                        
                }
            }
    }
    }
    func saveCard() {
        
        if formData.name.trimmingCharacters(in: .whitespaces).isEmpty || formData.email.isEmpty || formData.company.isEmpty || formData.jobTitle.isEmpty || formData.phoneNumber.isEmpty {
            showingAlert.toggle()
            return
        }
        else {
            
            let imageData = formData.profileImage?.jpegData(compressionQuality: 0.8)
            
            if let card = card {
                card.name = formData.name
                card.jobTitle = formData.jobTitle
                card.company = formData.company
                card.emailAddress = formData.email
                card.phoneNumber = formData.phoneNumber
                card.cardColor = formData.selectedColor
                card.profileImageData = imageData
            } else {
                // Create new card
                let newCard = BusinessCard(
                    name: formData.name,
                    jobTitle: formData.jobTitle,
                    company: formData.company,
                    emailAddress: formData.email,
                    phoneNumber: formData.phoneNumber,
                    cardColor: formData.selectedColor,
                    profileImageData: imageData
                    
                )
                context.insert(newCard)
            }
            dismiss()
        }

    }
}

#Preview {
    CreateEditCardView()
}
