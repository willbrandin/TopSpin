//
//  ComplicationController.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/21/20.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "monthly.summary.complication", displayName: "Monthly Summary", supportedFamilies: [CLKComplicationFamily.graphicRectangular]),
            CLKComplicationDescriptor(identifier: "montly.summary.vertical.complication", displayName: "Monthly Summary", supportedFamilies: [CLKComplicationFamily.graphicRectangular])

            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        if complication.identifier == "monthly.summary.complication" {
            let summary = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0)
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: CLKComplicationTemplateGraphicRectangularFullView(HistorySummaryComplicationView(summary: summary))))
        } else if complication.identifier == "montly.summary.vertical.complication" {
            let summary = UserDefaultsManager.shared.summaryEntry ?? MatchSummary(id: UUID(), monthRange: Date(), wins: 0, loses: 0, calories: 0, avgHeartRate: 0)
            handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: CLKComplicationTemplateGraphicRectangularFullView(VerticalSummaryComplicationView(summary: summary))))
        }
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        let summary = MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 8, calories: 689, avgHeartRate: 154)

        if complication.identifier == "monthly.summary.complication" {
            handler(CLKComplicationTemplateGraphicRectangularFullView(HistorySummaryComplicationView(summary: summary)))
        } else {
            handler(CLKComplicationTemplateGraphicRectangularFullView(VerticalSummaryComplicationView(summary: summary)))
        }
    }
}
