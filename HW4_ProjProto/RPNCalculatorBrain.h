//
//  RPNstack.h
//  RPNCalculator
//
//  Created by V.Anh Tran on 1/21/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPNCalculatorBrain : NSObject<UITableViewDataSource> {
	
}
@property (strong, nonatomic) NSMutableArray * stack;
@property (strong, nonatomic) NSMutableArray * history;

-(void)push:(NSNumber*)value;
-(void)cleanUp;

-(NSNumber*)doBinaryOperator:(NSString*)operatorString;
-(NSNumber*)doTopOperandFunction:(NSString*)functionName;
-(NSNumber*)doNonOperandFunction:(NSString*)functionName;

@end
