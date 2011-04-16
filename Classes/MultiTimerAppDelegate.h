//
//  MultiTimerAppDelegate.h
//  MultiTimer
//
//  Created by lbschmiedl on 16.12.10.
//  Copyright 2010 Institut für Medieninformatik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiTimerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

