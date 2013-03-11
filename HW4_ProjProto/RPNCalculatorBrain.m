//
//  RPNstack.m
//  RPNCalculator
//
//  Created by V.Anh Tran on 1/21/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "RPNCalculatorBrain.h"

@implementation RPNCalculatorBrain


#pragma mark - lazy init
-(NSMutableArray*)stack{
	if (_stack == nil) _stack = [[NSMutableArray alloc]initWithObjects:@(0), nil];
	return _stack;
}


-(NSMutableArray*)history{
	if (_history == nil) _history = [[NSMutableArray alloc]init];
	return _history;
}



-(void)push:(NSNumber*)value{
	[self.stack addObject:value];
}

#pragma mark - Require Task 5

-(void)cleanUp{
	[self.stack removeAllObjects];
	[self.history removeAllObjects];
}

#pragma mark - Required Task 6

-(NSNumber*)doBinaryOperator:(NSString*)operatorString{
	//hanle not enough number in stack to do operation
	
	NSNumber *a,*b,*c;
	
	//Lack of operand, replace with 0 (Required Task 6)
	if (self.stack.count >= 2){
		b = [self.stack lastObject];
		[self.stack removeLastObject];
		a = [self.stack lastObject];
		[self.stack removeLastObject];
	}else
	if (self.stack.count == 1){
		b = [self.stack lastObject];
		[self.stack removeLastObject];
		a = @(0);
	}else {
		a = b = @(0);
	}


	NSString * log;
	
	if ([operatorString isEqualToString:@"+"]) {
		c = @(a.doubleValue  + b.doubleValue);
		log = [NSString stringWithFormat:@"%@ = %@ + %@",c,a,b];
	}else if ([operatorString isEqualToString:@"-"]) {
		c = @(a.doubleValue  - b.doubleValue);
		log = [NSString stringWithFormat:@"%@ = %@ - %@",c,a,b];
	}else if ([operatorString isEqualToString:@"*"]) {
		c = @(a.doubleValue  * b.doubleValue);
		log = [NSString stringWithFormat:@"%@ = %@ * %@",c,a,b];
	}else if ([operatorString isEqualToString:@"/"]) {
		if (b.doubleValue == 0) {
			[self.stack addObject:a];//Re add a because user probaly do this by mistake
			log = [NSString stringWithFormat:@"Math Error: divide by zero"];
			c=b;
		}else{
			c = @(a.doubleValue  / b.doubleValue);
			log = [NSString stringWithFormat:@"%@ = %@ / %@",c,a,b];
		}
	}
	[self.history addObject:log];
	[self.stack addObject:c];
	return c;
}

#pragma mark - Required Task 3

-(NSNumber*)doTopOperandFunction:(NSString*)functionName{
	
	NSNumber *x,*y;
	
	if (self.stack.count > 1){
		x = [self.stack lastObject];
		[self.stack removeLastObject];
	}else {
		x = @(0);
	}

	NSString * log;
	
	if ([functionName isEqualToString:@"sin"]) {
		y = @(sin(x.doubleValue));
		log = [NSString stringWithFormat:@"%@ = sin(%@)",y,x];
	}else if ([functionName isEqualToString:@"cos"]) {
		y = @(cos(x.doubleValue));
		log = [NSString stringWithFormat:@"%@ = cos(%@)",y,x];
	}else if ([functionName isEqualToString:@"sqrt"]) {
		if (x.doubleValue < 0) {
			y=x; //Not do square root but display the value instead
			log = [NSString stringWithFormat:@"Math Error: square-root of negative number"];
		}else{
			y = @(sqrt(x.doubleValue));
			log = [NSString stringWithFormat:@"%@ = sqrt(%@)",y,x];
		}
	}
	[self.history addObject:log];
	[self.stack addObject:y];
	return y;

}

-(NSNumber*)doNonOperandFunction:(NSString*)functionName{
	NSNumber *z;
	
	NSString * log;
	
	if ([functionName isEqualToString:@"π"]) {
		z = @(M_PI);
		log = @"Add to stack: π";
	}
	[self.history addObject:log];
	[self.stack addObject:z];
	return z;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.stack count];
}

#pragma mark - Require Task 4

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	static NSString *CellIdentifier = @"CellRight";
	
	int row=[tableView numberOfRowsInSection:indexPath.section]-1-indexPath.row; // reverse index
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	// Configure the cel..
	NSLog(@"row %d = %@",row,[self.stack objectAtIndex:row]);
	cell.textLabel.text = ((NSNumber*)[self.stack objectAtIndex:row]).stringValue;
		
	return cell;

}



@end
