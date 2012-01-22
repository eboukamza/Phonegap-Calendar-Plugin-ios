//
//  calendarPlugin.m
//
//  Created by Felix Montanez on 01-17-2012
//  MIT Licensed
//
//  Copyright 2012 AMFMMultiMedia. All Rights Reserved.
//

#import "calendarPlugin.h"
#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>

@implementation calendarPlugin
@synthesize eventStore;
@synthesize defaultCalendar;


-(void)createEvent:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options 
{
    //Get the Event store object
    store = [[EKEventStore alloc] init];
    myEvent = [EKEvent eventWithEventStore: store];
    
    NSString* title      = [arguments objectAtIndex:1];
    NSString* location   = [arguments objectAtIndex:2];
    NSString* message    = [arguments objectAtIndex:3];
    NSString *startDate  = [arguments objectAtIndex:4];
    NSString *endDate    = [arguments objectAtIndex:5];
    
    
    //creating the dateformatter object
    NSDateFormatter *sDate = [[[NSDateFormatter alloc] init] autorelease];
    [sDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myStartDate = [sDate dateFromString:startDate];
    
    
    NSDateFormatter *eDate = [[[NSDateFormatter alloc] init] autorelease];
    [eDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myEndDate = [eDate dateFromString:endDate];
    
    
    myEvent.title = title;
    myEvent.location = location;
    myEvent.notes = message;
    myEvent.startDate = myStartDate;
    myEvent.endDate = myEndDate;
    myEvent.calendar = store.defaultCalendarForNewEvents;
    
    
    EKAlarm *reminder = [EKAlarm alarmWithRelativeOffset:-2*60*60];
    
    [myEvent addAlarm:reminder];
    
    NSError *error;
    BOOL saved = [store saveEvent:myEvent span:EKSpanThisEvent
                            error:&error];
    if (saved) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:@"Saved to Calendar" delegate:self
                                              cancelButtonTitle:@"Thank you!"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        
    }
}

//-(NSArray *) fetchEvents {
    store = [[EKEventStore alloc] init];
    myEvent = [EKEvent eventWithEventStore: store];
    
    NSString *startSearchDate  = [arguments objectAtIndex:1];
    NSString *endSearchDate    = [arguments objectAtIndex:2];
    
    
    //creating the dateformatter object
    NSDateFormatter *sDate = [[[NSDateFormatter alloc] init] autorelease];
    [sDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myStartDate = [sDate dateFromString:startSearchDate];
    
    
    NSDateFormatter *eDate = [[[NSDateFormatter alloc] init] autorelease];
    [eDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myEndDate = [eDate dateFromString:endSearchDate];

    
    NSArray *calendarArray = [NSArray arrayWithObject:defaultCalendar];
    NSPredicate *predicate = [self.eventStore
                              predicateForEventsWithStartDate:startDate
                              endDate:endDate calendars:calendarArray];
    NSArray *eventList = [self.eventStore
                          eventsMatchingPredicate:predicate];
    return eventList;
}

//- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Event List";
    self.eventStore = [[EKEventStore alloc] init];
    self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
    self.events = [NSArray arrayWithArray:[self fetchEventsForTommorrow]];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//-(void)deleteEvent:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {}

/*-(void)findEvent:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    
    store = [[EKEventStore alloc] init];
    myEvent = [EKEvent eventWithEventStore: store];

    NSString *startSearchDate  = [arguments objectAtIndex:1];
    NSString *endSearchDate    = [arguments objectAtIndex:2];
    
    
    //creating the dateformatter object
    NSDateFormatter *sDate = [[[NSDateFormatter alloc] init] autorelease];
    [sDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myStartDate = [sDate dateFromString:startSearchDate];
    
    
    NSDateFormatter *eDate = [[[NSDateFormatter alloc] init] autorelease];
    [eDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *myEndDate = [eDate dateFromString:endSearchDate];

    
    // Create the predicate
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:myStartDate endDate:myEndDate calendars:defaultCalendar]; 
    
    
    // eventStore is an instance variable.
    // Fetch all events that match the predicate.
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    [self setEvents:events];
    
    
}

//-(void)modifyEvent:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    EKEventViewController *eventViewController = [[EKEventViewController alloc] init];
    eventViewController.event = myEvent;
    eventViewController.allowsEditing = YES;
    navigationController = [[UINavigationController alloc]
                            initWithRootViewController:eventViewController];
    [eventViewController release];
}*/


//delegate method for EKEventEditViewDelegate
-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    [self dismissModalViewControllerAnimated:YES];
    [self release];
}
@end