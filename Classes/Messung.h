//
//  Messung.h
//  MultiTimer
//
//  Created by lbschmiedl on 18.12.10.
//  Copyright 2010 Institut für Medieninformatik. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Messung : NSObject {
	NSDate *startTime;
	NSTimeInterval dauer;
}

@property (nonatomic, retain) NSDate *startTime;
@property NSTimeInterval dauer;

- (NSString *) ValuesAsText;

@end
