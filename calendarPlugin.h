//
//
//  Created by Felix Montanez on 01-17-2012
//  MIT Licensed
//
//  Copyright 2012 AMFMMultiMedia. All Rights Reserved.
//


#import <Foundation/Foundation.h>
#ifdef PHONEGAP_FRAMEWORK
#import <PhoneGap/PGPlugin.h>
#else
#import "PGPlugin.h"
#endif
#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>

@interface calendarPlugin : PGPlugin <EKEventEditViewDelegate> {
    
	EKEventStore *eventStore;
    EKCalendar *defaultCalendar;
    NSArray *events;
    
    //future plan to have global type variables
    EKEvent *myEvent;
    EKEventStore *store;
    
}

@property (nonatomic,retain) NSArray *events;
@property (nonatomic,retain) EKEventStore *eventStore;
@property (nonatomic,retain) EKCalendar *defaultCalendar;

-(NSArray *)fetchEvents;

// Calendar Instance methods
- (void)createEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//- (void)modifyEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//- (void)findEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//- (void)deleteEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end