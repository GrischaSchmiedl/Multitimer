//
//  Messung.m
//  MultiTimer
//
//  Created by lbschmiedl on 18.12.10.
//  Copyright 2010 Institut für Medieninformatik. All rights reserved.
//

#import "Messung.h"


@implementation Messung

@synthesize startTime, dauer;

- (NSString *) ValuesAsText {
	return [NSString stringWithFormat:@"%f",dauer];
}

@end
