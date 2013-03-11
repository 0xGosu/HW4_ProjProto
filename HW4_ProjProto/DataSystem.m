//
//  DataSystem.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/8/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "DataSystem.h"


@implementation DataSystem{
	NSMutableArray * sources;
	NSMutableArray * flows;
	
	NSUserDefaults *localStorage;
}


-(id)init{
	
	localStorage = [NSUserDefaults standardUserDefaults];
	
	[self loadDataFromLocalStorage];
	
	if (sources==nil || flows == nil) {
		sources = [NSMutableArray arrayWithObjects:@[@"???",@"question"]
		   ,@[@"My Wallet",@"wallet"]
		   ,@[@"Credit Card",@"credit-card"]
		   ,@[@"Daily Life",@"soft-drink"]
		   ,@[@"Luxury Life",@"airplane"]
		   , nil];
		flows = [NSMutableArray arrayWithObjects:@[@0,@2,@300] , @[@0,@1,@120], @[@2,@4,@50], @[@1,@3,@10], nil];
		NSLog(@"Create example data for DataSystem!");
	}
	
	NSLog(@"DataSystem Initalized!");
	return self;
}

#pragma mark - memory management

-(void)releaseMemory{
	[self saveDataToLocalStorage];
	sources = nil;
	flows = nil;
}

-(void)undoReleaseMemory{
	[self loadDataFromLocalStorage];
}

#pragma mark - source

-(NSString*)getNameOfSourceWithID:(int)i{
	return [[sources objectAtIndex:i] objectAtIndex:0];
}

-(UIImage*)getIconOfSourceWithID:(int)i{
	NSString * iconName = [[sources objectAtIndex:i] objectAtIndex:1];
	if (iconName == NULL || iconName.length==0) {
		return nil;
	}else
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iconName ofType:@"png" inDirectory:@"iconbeast"]];
}

-(int)numberOfSource{
	return [sources count];
}

-(double)getBalanceOfSourceWithID:(int)i{
	int balance = 0;
	for (NSArray * flow in flows) {
		//a flow from this source
		if ([[flow objectAtIndex:0] intValue] == i) {
			balance -= [[flow objectAtIndex:2] intValue];
		}
		//a flow to this source
		if ([[flow objectAtIndex:1] intValue] == i) {
			balance += [[flow objectAtIndex:2] intValue];
		}
	}
	return balance;
}


#pragma mark - flow

-(int)getFromSourceIDOfFlowWithID:(int)i{
	return [[[flows objectAtIndex:i]objectAtIndex:0] intValue];
}
-(int)getToSourceIDOfFlowWithID:(int)i{
	return [[[flows objectAtIndex:i]objectAtIndex:1] intValue];
}
-(double)getAmountOfFlowWithID:(int)i{
	return [[[flows objectAtIndex:i]objectAtIndex:2] doubleValue];
}

-(int)numberOfFlows{
	return [flows count];
}

#pragma mark - add new
-(void)addNewSourceWithName:(NSString *)name IconName:(NSString*)iconName{
	NSLog(@"Add a new source: %@ (icon:%@)",name,iconName);
	[sources addObject:@[name,iconName]];
}


-(void)addNewFlowFromSourceID:(int)fromID toSourceID:(int)toID withAmount:(double)amount{
	NSLog(@"Add a new flow: %@ => %@ = %.2f"
	,[self getNameOfSourceWithID:fromID]
	,[self getNameOfSourceWithID:toID]
	,amount);
	
	[flows addObject:@[@(fromID),@(toID),@(amount)]];
}

#pragma mark - localStorage 

-(void)saveDataToLocalStorage{
	[localStorage setValue:sources forKey:@"sources"];
	[localStorage setValue:flows forKey:@"flows"];
	NSLog(@"Save current value of DataSystem to localStorage success!");
}

-(void)loadDataFromLocalStorage{
	sources = [localStorage valueForKey:@"sources"];
	flows = [localStorage valueForKey:@"flows"];
}

@end
