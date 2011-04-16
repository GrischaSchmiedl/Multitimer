//
//  RootViewController.m
//  MultiTimer
//
//  Created by lbschmiedl on 16.12.10.
//  Copyright 2010 Institut für Medieninformatik. All rights reserved.
//

#import "RootViewController.h"
#import "Messung.h"
#import "MessungListController.h"


@implementation RootViewController
@synthesize lblTimeTotal,lblTimeA,lblTimeB,lblCountA,lblCountB,lblAvgTimeA,lblAvgTimeB;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	isRunning = NO;
	isRunningA = NO;
	isRunningB = NO;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (NSString *)secondsToString:(NSTimeInterval)interval
{
	static const double minute = 60;
	static const double hour = 3600;
	
	NSTimeInterval workInterval = interval;
	
	double hours = 0;
	double minutes = 0;
	double seconds = 0;
	double hundertstel = 0;
	
	hours = floor(workInterval / hour);
	workInterval -= hour * hours;
	
	minutes = floor(workInterval / minute);
	workInterval -= minute * minutes;
	
	seconds = floor(workInterval);
	workInterval -= seconds;
	
	hundertstel = floor(workInterval*100);
	
	NSMutableString * str = [[[NSMutableString alloc] init] autorelease];
	
	if (hours != 0)[str appendString:[NSString stringWithFormat:@"%.0lf:",hours]];
	
	if (minutes != 0)[str appendString:[NSString stringWithFormat:@"%.0lf:",minutes]];
	
	if (seconds < 10) [str appendString:[NSString stringWithFormat:@"0%.0lf.",seconds]];
	else [str appendString:[NSString stringWithFormat:@"%.0lf.",seconds]];
	
	if (hundertstel<10) [str appendString:[NSString stringWithFormat:@"0%.0lf",hundertstel]];
	else [str appendString:[NSString stringWithFormat:@"%.0lf",hundertstel]];
	
	if ([str isEqualToString:@""]) [str setString:@"00:00:00"];
	
	return str;
}



- (void) timerMethod: (NSTimer *)timer {
	timerMethodCalled++;
	NSDate *now = [NSDate date];
	NSTimeInterval interval = [now timeIntervalSinceDate:timerTotalStarted];
	lblTimeTotal.text = [self secondsToString:interval];
	if (isRunningA)	{
		NSTimeInterval intervalA = [now timeIntervalSinceDate:timerAStarted];
		lblTimeA.text = [self secondsToString:TimeA+intervalA]; 
	}
	if (isRunningB)	{
		NSTimeInterval intervalB = [now timeIntervalSinceDate:timerBStarted];
		lblTimeB.text = [self secondsToString:TimeB+intervalB]; 
	}
}

- (void) resetAll {
	TimeA = 0;
	TimeB = 0;
	countA = 0;
	countB = 0;
	timerMethodCalled = 0;
	lblTimeTotal.text = @"0.00";
	lblTimeA.text = @"0.00";
	lblTimeB.text = @"0.00";
	lblCountA.text = @"0";
	lblCountB.text = @"0";
	lblAvgTimeA.text = @"0.00";
	lblAvgTimeB.text = @"0.00";
	[timerAArray removeAllObjects];
}


- (IBAction) btnStartPressed:(id)sender {
	if (!isRunning) {
		[self resetAll];
		isRunning = YES;
		timerTotalStarted = [NSDate date]; //sets start time
		[timerTotalStarted retain]; 
		t = [NSTimer scheduledTimerWithTimeInterval: 0.05
													target: self
													selector:@selector(timerMethod:)
													userInfo: nil repeats:YES];
	}
	

}

- (IBAction) btnStopPressed:(id)sender {
	if (isRunning) {
		[t invalidate];
		[timerTotalStarted release];
		isRunning = NO;
		
	}
}


- (IBAction) btnResetPressed:(id)sender {
	if (!isRunning) [self resetAll];
}

- (IBAction) btnDetailsPressed:(id)sender {
	MessungListController *mlc = [[MessungListController alloc] initWithNibName:@"MessungListController" bundle:nil];
	mlc.data = timerAArray;
	[self.navigationController pushViewController:mlc animated:YES];
	[mlc release];
}


- (IBAction) btnTimeATouchDown:(id)sender {
	if (isRunning && !isRunningA) {
		timerAStarted = [NSDate date]; //sets start time
		[timerAStarted retain];
		isRunningA =YES;
	}
}


- (IBAction) btnTimeBTouchDown:(id)sender {
	if (isRunning && !isRunningB) {
		timerBStarted = [NSDate date]; //sets start time
		[timerBStarted retain];
		isRunningB =YES;
	}
}


- (IBAction) btnTimeATouchUpInside:(id)sender {
	if (isRunning && isRunningA) {
		NSDate *now = [NSDate date];
		NSTimeInterval interval = [now timeIntervalSinceDate:timerAStarted];
		TimeA += interval;
		countA++;
		lblTimeA.text = [self secondsToString:TimeA];
		lblCountA.text = [NSString stringWithFormat:@"%d", countA];
		lblAvgTimeA.text = [self secondsToString:TimeA/countA];
		
		//Messung im Messungset speichern
		Messung *eineMessung = [[Messung alloc]init];
		eineMessung.startTime = timerAStarted;
		eineMessung.dauer = interval;
		if (timerAArray == NULL) {
			timerAArray = [[NSMutableArray alloc] initWithCapacity:10];
		}
		[timerAArray addObject:eineMessung];
		[eineMessung release];
		
		[timerAStarted release];
		isRunningA = NO;
	}
}


- (IBAction) btnTimeBTouchUpInside:(id)sender {
	if (isRunning && isRunningB) {
		NSDate *now = [NSDate date];
		NSTimeInterval interval = [now timeIntervalSinceDate:timerBStarted];
		TimeB += interval;
		countB++;
		lblTimeB.text = [self secondsToString:TimeB];
		lblCountB.text = [NSString stringWithFormat:@"%d", countB];
		lblAvgTimeB.text = [self secondsToString:TimeB/countB];
		[timerBStarted release];
		isRunningB = NO;
	}
}


- (IBAction) btnTimeATouchUpOutside:(id)sender {
	if (isRunning && isRunningA) {
		lblTimeA.text = [self secondsToString:TimeA];
		[timerAStarted release];
		isRunningA = NO;
	}
}


- (IBAction) btnTimeBTouchUpOutside:(id)sender {
	if (isRunning && isRunningB) {
		lblTimeB.text = [self secondsToString:TimeB];
		[timerBStarted release];
		isRunningB = NO;
	}
}



#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[lblTimeTotal release];
	[lblTimeA release];
	[lblTimeB release];
	[lblCountA release];
	[lblCountB release];
	[lblAvgTimeA release];
	[lblAvgTimeB release];
    [super dealloc];
}


@end

