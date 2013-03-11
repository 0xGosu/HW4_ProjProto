//
//  FirstViewController.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/6/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "BalanceVC.h"
#import "AppDelegate.h"
#import "NewFlowVC.h"

@interface BalanceVC ()

@property (weak, nonatomic) IBOutlet UIProgressView *balanceBar;

@end

@implementation BalanceVC{
	AppDelegate * app;
	int numberOfFlowsLastKnow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
	numberOfFlowsLastKnow = [app.dataSystem numberOfFlows];
}


-(void)viewDidAppear:(BOOL)animated{
	if (numberOfFlowsLastKnow > 0 && numberOfFlowsLastKnow != [app.dataSystem numberOfFlows]) {
		NSLog(@"Detect a new flows, representing balance change.. ");
		[self.balanceBar setProgress:self.balanceBar.progress*1.5 animated:true];
		numberOfFlowsLastKnow=[app.dataSystem numberOfFlows];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button

- (IBAction)newFlowAction:(UIButton *)sender {
	numberOfFlowsLastKnow = [app.dataSystem numberOfFlows];
	[self performSegueWithIdentifier:@"newFlow" sender:sender];
}


#pragma mark - segue push pop present
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	NSLog(@"Pressed=%d",[sender tag]);
	NSArray * titleArray = @[@"",@"Income",@"Expense",@"Transaction",@"Loan"];
	((NewFlowVC*)segue.destinationViewController).title = [titleArray objectAtIndex:[sender tag]];	
}

@end
