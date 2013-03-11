//
//  ViewController.m
//  RPNCalculator
//
//  Created by V.Anh Tran on 1/19/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "EmbededCalculatorVC.h"

@interface EmbededCalculatorVC (){
	bool typing;
}

@property (strong, nonatomic) IBOutlet RPNCalculatorBrain *brain;



#pragma mark - Require Task 4 
@property (weak, nonatomic) IBOutlet UITableView *smallTableView; //I use a UITableView instead of UILabel


@end

@implementation EmbededCalculatorVC

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSLog(@"brain = %@",self.brain);
	typing=false;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button function

- (IBAction)numberButtonClicked:(UIButton *)sender {
	UIButton * button = sender;
	//NSLog(@"Press:%@",button.titleLabel.text);
	
	if([self.display.text isEqualToString:@"0"]){
		if([button.titleLabel.text isEqualToString:@"0"])return;
		self.display.text = @"";
	}
	
	if (typing==false){
		self.display.text = @"";
	}
	
	self.display.text = [NSString stringWithFormat:@"%@%@",self.display.text,button.titleLabel.text];
	typing=true;
	AudioServicesPlaySystemSound(1200+button.titleLabel.text.intValue);
}

- (IBAction)enterButtonClicked:(UIButton *)sender {
	NSNumber * newNumber = [NSNumber numberWithDouble:[self.display.text doubleValue]];
	[self.brain push:newNumber];
	self.display.text = @"0";
	
	[self.smallTableView reloadData];
	typing=false;
	
	AudioServicesPlaySystemSound(1105);
}

#pragma mark - Require Task 2

- (IBAction)dotButtonClicked:(UIButton *)sender {

	//Make sure only one dot in the label
	if ([self.display.text rangeOfString:@"."].location == NSNotFound)
		self.display.text = [NSString stringWithFormat:@"%@.",self.display.text];
	
	typing=true;
	AudioServicesPlaySystemSound(1211);
}

- (IBAction)delButtonClicked:(UIButton *)sender {
	if ([self.display.text length]==1)self.display.text = @"0";
	else{
		self.display.text= [self.display.text substringToIndex:[self.display.text length]-1];
	}
	typing=true;
	AudioServicesPlaySystemSound(1103);
}

- (IBAction)fastDelete:(UIButton *)sender {
	if ([self.display.text length]<=2)self.display.text = @"0";
	else{
		self.display.text = [self.display.text substringToIndex:self.display.text.length-2];
	}
	typing=true;
	AudioServicesPlaySystemSound(1103);
}

- (IBAction)hardDelete:(id)sender {
	self.display.text = @"0";
	typing=true;
	AudioServicesPlaySystemSound(1103);
}

- (IBAction)clearButtonClicked:(UIButton *)sender {
	[self hardDelete:nil];
	[self.brain cleanUp];
	[self.smallTableView reloadData];
}


- (IBAction)binaryOperatorButtonClicked:(UIButton *)sender {
	if (typing==true)[self enterButtonClicked:nil];
	[self displayResult:[self.brain doBinaryOperator:sender.titleLabel.text]];
	typing=false;
	AudioServicesPlaySystemSound(1104);
}


- (IBAction)topOperandFunctionButtonClicked:(UIButton *)sender {
	if (typing==true)[self enterButtonClicked:nil];
	[self displayResult:[self.brain doTopOperandFunction:sender.titleLabel.text]];
	typing=false;
	AudioServicesPlaySystemSound(1104);
}

- (IBAction)nonOperandFunctionButtonClicked:(UIButton *)sender {
	if (typing==true)[self enterButtonClicked:nil];
	[self displayResult:[self.brain doNonOperandFunction:sender.titleLabel.text]];
	typing=false;
	AudioServicesPlaySystemSound(1104);
}


-(void)displayResult:(NSNumber*) result{
	NSLog(@"result = %@",result);
	self.display.text = [NSString stringWithFormat:@"%.2f",result.doubleValue];
	[self.smallTableView reloadData];
}


@end
