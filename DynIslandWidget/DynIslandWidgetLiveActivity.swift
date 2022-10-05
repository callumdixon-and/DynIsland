//
//  DynIslandWidgetLiveActivity.swift
//  DynIslandWidget
//
//  Created by Callum Dixon on 05/10/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PizzaDeliveryActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PizzaDeliveryAttributes.self) { context in
            // Create the view that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // ...
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            // Create the views that appear in the Dynamic Island.
            DynamicIsland {
                // Create the expanded view.
                DynamicIslandExpandedRegion(.leading) {
                    Label("\(context.attributes.numberOfPizzas) Pizzas", systemImage: "bag")
                        .foregroundColor(.indigo)
                        .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text("\(context.state.driverName) is on their way!")
                        .lineLimit(1)
                        .font(.caption)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Button {
                        // Deep link into your app.
                    } label: {
                        Label("Call driver", systemImage: "phone")
                    }
                    .foregroundColor(.indigo)
                }
            } compactLeading: {
                Label {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
                } icon: {
                    Image(systemName: "bag")
                        .foregroundColor(.indigo)
                }
                .font(.caption2)
            } compactTrailing: {
                Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 40)
                    .font(.caption2)
            } minimal: {
                VStack(alignment: .center) {
                    Image(systemName: "timer")
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
            .keylineTint(.cyan)
            
        }
    }
}


struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<PizzaDeliveryAttributes>
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(context.state.driverName) is on their way with your pizza!")
            Spacer()
            HStack {
                Spacer()
                Label {
                    Text("\(context.attributes.numberOfPizzas) Pizzas")
                } icon: {
                    Image(systemName: "bag")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
                Label {
                    Text(timerInterval: context.state.deliveryTimer, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 50)
                        .monospacedDigit()
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.indigo)
                }
                .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .activitySystemActionForegroundColor(.indigo)
        .activityBackgroundTint(.cyan)
    }
}
