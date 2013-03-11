//
//  DataSystem.h
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/8/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSystem : NSObject

-(void)releaseMemory;
-(void)undoReleaseMemory;


-(NSString*)getNameOfSourceWithID:(int)i;
-(UIImage*)getIconOfSourceWithID:(int)i;
-(int)numberOfSource;

-(double)getBalanceOfSourceWithID:(int)i;

-(int)getFromSourceIDOfFlowWithID:(int)i;
-(int)getToSourceIDOfFlowWithID:(int)i;
-(double)getAmountOfFlowWithID:(int)i;

-(int)numberOfFlows;

-(void)addNewSourceWithName:(NSString *)name IconName:(NSString*)iconName;

-(void)addNewFlowFromSourceID:(int)fromID toSourceID:(int)toID withAmount:(double)amount;

-(void)saveDataToLocalStorage;
-(void)loadDataFromLocalStorage;

@end
