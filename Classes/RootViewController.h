//
//  RootViewController.h
//  MultiTimer
//
//  Created by lbschmiedl on 16.12.10.
//  Copyright 2010 Institut für Medieninformatik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	NSTimer *t;
	bool isRunning;
	bool isRunningA;
	bool isRunningB;
	int timerMethodCalled;
	int countA;
	int countB;
	NSTimeInterval TimeA;
	NSTimeInterval TimeB;
	NSDate *timerTotalStarted;
	NSDate *timerAStarted;
	NSDate *timerBStarted;
	
	NSMutableArray *timerAArray;
	NSMutableArray *timerBArray;
	
	IBOutlet UILabel *lblTimeTotal;
	IBOutlet UILabel *lblTimeA;
	IBOutlet UILabel *lblTimeB;
	IBOutlet UILabel *lblCountA;
	IBOutlet UILabel *lblCountB;
	IBOutlet UILabel *lblAvgTimeA;
	IBOutlet UILabel *lblAvgTimeB;
}

@property(nonatomic, retain) IBOutlet UILabel *lblTimeTotal;
@property(nonatomic, retain) IBOutlet UILabel *lblTimeA;
@property(nonatomic, retain) IBOutlet UILabel *lblTimeB;
@property(nonatomic, retain) IBOutlet UILabel *lblCountA;
@property(nonatomic, retain) IBOutlet UILabel *lblCountB;
@property(nonatomic, retain) IBOutlet UILabel *lblAvgTimeA;
@property(nonatomic, retain) IBOutlet UILabel *lblAvgTimeB;

- (IBAction) btnStartPressed:(id)sender;
- (IBAction) btnStopPressed:(id)sender;
- (IBAction) btnResetPressed:(id)sender;
- (IBAction) btnDetailsPressed:(id)sender;
- (IBAction) btnTimeATouchDown:(id)sender;
- (IBAction) btnTimeBTouchDown:(id)sender;
- (IBAction) btnTimeATouchUpInside:(id)sender;
- (IBAction) btnTimeBTouchUpInside:(id)sender;
- (IBAction) btnTimeATouchUpOutside:(id)sender;
- (IBAction) btnTimeBTouchUpOutside:(id)sender;

@end
