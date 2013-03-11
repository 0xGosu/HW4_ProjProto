//
//  AppDelegate.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/6/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	NSLog(@"applicationDidEnterBackground");
	[self.dataSystem releaseMemory];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	NSLog(@"applicationWillEnterForeground");
	[self.dataSystem undoReleaseMemory];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	NSLog(@"applicationDidBecomeActive");
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	NSLog(@"applicationWillTerminate");
	[self.dataSystem saveDataToLocalStorage];
}

#pragma mark - Lazy init

-(DataSystem*) dataSystem{
	if (_dataSystem == nil) {
		_dataSystem = [[DataSystem alloc]init];
	}
	return _dataSystem;
}

@end
