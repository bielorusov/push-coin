//
//  OtpVerificationView.swift
//  PushCoin
//
//  Created by Dmitriy Belorusov on 9/13/22.
//

import SwiftUI

struct OTPVerificationView: View {
  @StateObject var otpModel: OTPViewModel = .init()
  @StateObject private var countDownViewModel = CountDownViewModel()
  let resendDelay: Float = 3 // Resend delay in minutes
  private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  //MARK: TextField FocusState
  @FocusState var activeField: OTPField?
  
  var body: some View {
    VStack(spacing: Geometry.Size.padding) {
        Text("A 4-digit code has been sent to your email confirmation.")
        .font(Font.App.headMedium)
        .frame(width: Geometry.Size.formWidth)
        
      OTPField()
      
      Text("Request a new verification code in \(countDownViewModel.time)").subheadlineStyle()
        .multilineTextAlignment(.leading)
      
      Button(action: {
        hideKeyboard()
        print("Vefiry OTP button pressed")
      }){
        Text("Verify")
          .capsuleButtonPrimaryStyle()
      }
      .disabled(checkStates())
      .opacity(checkStates() ? 0.4 : 1)
            
      HStack {
        Text("Don't get code?")
          .font(Font.App.subheadline)
        Button(action: {
          countDownViewModel.start(minutes: resendDelay)
        }) {
          Text("Resend code")
            .font(Font.App.subheadline)
        }
        .disabled(countDownViewModel.isActive)
      }
      .frame(maxWidth: Geometry.Size.formWidth, alignment: .center)
      
    }
    .onChange(of: otpModel.otpFields) { newValue in
      OTPCondition(value: newValue)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
        activeField = .field1
        countDownViewModel.start(minutes: resendDelay)
      }
    }
    .onReceive(timer) { _ in
      countDownViewModel.updateCountdown()
    }
  }
  
  // MARK: disable, enable button state
  func checkStates() -> Bool {
    for index in 0..<4 {
      if otpModel.otpFields[index].isEmpty { return true }
    }
    
    return false
  }
  
  // MARK: Conditions for Custom OTP Field & Limiting Only one Text
  func OTPCondition(value: [String]){
    // Checking if OTP is Pressed
    for index in 0..<3 {
      if value[index].count == 4 {
        DispatchQueue.main.async {
          otpModel.otpText = value[index]
          otpModel.otpFields[index] = ""
          
          // Updating all TextFields with Value
          for item in otpModel.otpText.enumerated() {
            otpModel.otpFields[item.offset] = String(item.element)
          }
        }
        
        return
      }
    }
  
    
    // Moving next field if current field type
    for index in 0..<3 {
      if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
        activeField = activeStateForIndex(index: index + 1)
      }
    }
    
    // Moving back if Current is Empty and  Previous is not Empty
    for index in 1...3 {
      if value[index].isEmpty && !value[index - 1].isEmpty {
        activeField = activeStateForIndex(index: index - 1)
      }
    }
    
    for index in 0..<4{
      if value[index].count > 1 {
        otpModel.otpFields[index] = String(value[index].last!)
      }
    }
  }
  
  //MARK: custom OTP textField
  @ViewBuilder
  func OTPField()->some View {
    HStack(spacing: Geometry.Size.padding){
      ForEach(0..<4, id: \.self) { index in
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .strokeBorder(activeField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3), lineWidth: 1)
          .frame(width: 50,height: 52, alignment: .center)
        .overlay {
          TextField("X", text: $otpModel.otpFields[index])
            .focused($activeField, equals: activeStateForIndex(index: index))
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .font(Font.App.inputMedium)
        }
      }
    }
  }
    
  // MARK: Resurn Enum value by Index
  func activeStateForIndex(index: Int)->OTPField {
    switch index {
      case 0: return .field1
      case 1: return .field2
      case 2: return .field3
      default: return .field4
    }
  }  
}

// MARK: FocusState enum
enum OTPField {
  case field1
  case field2
  case field3
  case field4
}

struct OTPVerificationView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      OTPVerificationView()
    }
  }
}

