//
//  ContentView.swift
//  DynIsland
//
//  Created by Callum Dixon on 05/10/2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    
    @State var deliveryActivity: Activity<PizzaDeliveryAttributes>?
    
    func startActivity(){
        
        var future = Calendar.current.date(byAdding: .minute, value: (Int(0)), to: Date())!
        future = Calendar.current.date(byAdding: .second, value: (Int(10)), to: future)!
        let date = Date.now...future
        let initialContentState = PizzaDeliveryAttributes.ContentState(driverName: "Bill James", deliveryTimer:date)
        let activityAttributes = PizzaDeliveryAttributes(numberOfPizzas: 3, totalAmount: "$42.00", orderNumber: "12345")
        
        do {
             deliveryActivity = try Activity<PizzaDeliveryAttributes>.request(attributes: activityAttributes, contentState: initialContentState)
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
        }
    }
    
    func stopActivity() async {
        
        let finalStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Bill James", deliveryTimer: Date.now...Date.now)
        do {
            try await deliveryActivity?.end(using: finalStatus, dismissalPolicy: .default)
        } catch(let error) {
            print("Error ending the Live Activity: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Press start and close app to see Dynamic island, re open app and press stop to stop it")
            Button("Start", action: startActivity)
            Button("Stop", action: {Task {await stopActivity()}})
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
