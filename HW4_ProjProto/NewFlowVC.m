//
//  NewFlowVC.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/7/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "NewFlowVC.h"
#import "AppDelegate.h"
#import "EmbededCalculatorVC.h"
#import "CapturePhotoVC.h"

@interface NewFlowVC ()

@property (weak, nonatomic) IBOutlet UIView *dateContainer;

@property (weak, nonatomic) IBOutlet UIView *flowContainer;

@property (weak, nonatomic) IBOutlet UIView *noteContainer;

@property (weak, nonatomic) IBOutlet UIView *placeContainer;

@property (weak, nonatomic) IBOutlet UIView *photoTool;

@property (weak, nonatomic) IBOutlet UIView *calculator;


@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *toolSegment;

#pragma mark - container manual outlet

@property (weak, nonatomic) IBOutlet UIPickerView *fromSourcePicker;

@property (weak, nonatomic) IBOutlet UIPickerView *toSourcePicker;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (weak, nonatomic) IBOutlet MKMapView * mapView;

@property (weak, nonatomic) IBOutlet CapturePhotoVC * capturePhotoController;

#pragma mark - other


@property (strong, nonatomic) CLGeocoder* geoCoder;

@property (strong, nonatomic) MKPointAnnotation * userCurrentLocationPoint;

@end

@implementation NewFlowVC{
	AppDelegate * app;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
	// Do any additional setup after loading the view.
	int firstToolDisplay=1;
	[self displayTool:firstToolDisplay];
	[self.toolSegment setSelectedSegmentIndex:firstToolDisplay];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy init

-(CLGeocoder *)geoCoder{
	if (_geoCoder==nil) {
		_geoCoder = [[CLGeocoder alloc]init];
	}
	return _geoCoder;
}

#pragma mark - segment
-(void) displayTool:(int)i{
	NSArray * toolViewList = [NSArray arrayWithObjects:self.dateContainer,self.flowContainer,self.noteContainer,self.placeContainer,self.photoTool,self.calculator,nil];
	for (UIView*view  in toolViewList)view.hidden=true;
	[(UIView*)[toolViewList objectAtIndex:i] setHidden:false];
}

- (IBAction)segmentSwitched:(UISegmentedControl *)segment {
	int segNum = segment.selectedSegmentIndex;
	NSLog(@"segNum=%d",segNum);
	[self displayTool:segNum];
}


#pragma mark - pickerView datasource&deletage

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSLog(@"Number of sources:%d",[app.dataSystem numberOfSource]);
	return [app.dataSystem numberOfSource];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [app.dataSystem getNameOfSourceWithID:row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	if (view == nil) {
		NSLog(@"Init custom view for picker");

		
        UIImageView *imageView = [[UIImageView alloc] init];        
        imageView.frame = CGRectMake(0, 20, 20, 20);
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, pickerView.frame.size.width, 60)];
		label.text = @"sdfsdfdsf";
		label.textAlignment = NSTextAlignmentLeft;
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont systemFontOfSize:18];
		
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width - 30, 60)];
		[view insertSubview:imageView atIndex:0];
		[view insertSubview:label atIndex:1];
		
	}
	
	//geting subview out of custom view
	UIImageView *imageView = [view.subviews objectAtIndex:0];
	UILabel *label = [view.subviews objectAtIndex:1];
	
	imageView.image = [app.dataSystem getIconOfSourceWithID:row];
	label.text = [self pickerView:pickerView titleForRow:row forComponent:component];	
    return view;
}


#pragma mark - stepper

- (IBAction)stepperChanged:(UIStepper *)sender {
	double currentMoney = self.moneyLabel.text.doubleValue;
	
	if (sender.value==sender.stepValue) {
		currentMoney += sender.value;
	}else{
		currentMoney += sender.value - sender.stepValue;
	}
	
	if (currentMoney==0) {
		sender.value=0;
	}else{
		sender.value = sender.stepValue;
	}
	
	self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",currentMoney];
	
	//force resign keyboard
	if (self.noteTextView.isFirstResponder)[self.noteTextView resignFirstResponder];
}


#pragma mark - textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

#pragma mark - segue, push, pop

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	NSLog(@"Perform a segue:%@",segue.identifier);
	//NSLog(@"dest=%@",segue.destinationViewController);
	
	//geting view from container bind to property without create a new view controller
	if ([segue.identifier isEqualToString:@"flow"]) {
		self.fromSourcePicker = (UIPickerView*)[[segue.destinationViewController view] viewWithTag:1];
		self.toSourcePicker = (UIPickerView*)[[segue.destinationViewController view] viewWithTag:2];
		
		self.fromSourcePicker.dataSource = self;
		self.fromSourcePicker.delegate = self;
		
		self.toSourcePicker.dataSource = self;
		self.toSourcePicker.delegate = self;
		//NSLog(@"%@ to %@",self.fromSourcePicker, self.toSourcePicker);
	}
	
	//geting view from container bind to property without create a new view controller
	if ([segue.identifier isEqualToString:@"date"]) {
		self.datePicker = (UIDatePicker*)[[segue.destinationViewController view] viewWithTag:1];
		NSDate * today = [self.datePicker date];
		NSLog(@"today=%@",[today descriptionWithLocale:nil]);
	}
	
	if ([segue.identifier isEqualToString:@"note"]) {
		//geting view from container bind to property without create a new view controller
		self.noteTextView = (UITextView*)[[segue.destinationViewController view] viewWithTag:1];
		self.noteTextView.delegate = self;
		UIButton * pasteButton = (UIButton*)[[segue.destinationViewController view] viewWithTag:2];
		//send touch event to self for action pasteButtonPressed
		[pasteButton addTarget:self action:@selector(pasteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	}
	
	if ([segue.identifier isEqualToString:@"place"]) {
		self.mapView = (MKMapView*)[[segue.destinationViewController view] viewWithTag:1];
		self.mapView.delegate = self;
	}
	
	
	if ([segue.identifier isEqualToString:@"photo"]) {
		self.capturePhotoController = (CapturePhotoVC*)segue.destinationViewController;
	}
	
	if ([segue.identifier isEqualToString:@"calculator"]) {
		EmbededCalculatorVC * calc = (EmbededCalculatorVC*)segue.destinationViewController;
		calc.display = self.moneyLabel;
	}
}

- (IBAction)createNewFlowPressed:(UIBarButtonItem *)sender {
	NSLog(@"Flow created for date=%@",[[self.datePicker date] descriptionWithLocale:nil]);
	NSLog(@"Flow created at %@",self.userCurrentLocationPoint.subtitle);
    
	
	double currentMoney = self.moneyLabel.text.doubleValue;
	int fromSourceID=[self.fromSourcePicker selectedRowInComponent:0];
	int toSourceID=[self.toSourcePicker selectedRowInComponent:0];
	
	NSLog(@"from %@ to %@",[app.dataSystem getNameOfSourceWithID:fromSourceID],[app.dataSystem getNameOfSourceWithID:toSourceID]);
	NSLog(@"amount=%.2f",currentMoney);
	
	[app.dataSystem addNewFlowFromSourceID:fromSourceID toSourceID:toSourceID withAmount:currentMoney];
	
	[self.navigationController popViewControllerAnimated:true];
}

#pragma mark - MapView delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
	
	// Add an annotation
    self.userCurrentLocationPoint = [[MKPointAnnotation alloc] init];
    self.userCurrentLocationPoint.coordinate = userLocation.coordinate;
    self.userCurrentLocationPoint.title = @"You are here!";
    self.userCurrentLocationPoint.subtitle = @"???";
    
	[self.geoCoder reverseGeocodeLocation: self.mapView.userLocation.location completionHandler: ^(NSArray *placemarks, NSError *error) {
		
		//Get nearby address
		CLPlacemark *placemark = [placemarks objectAtIndex:0];
		
		//String to hold address
		NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
		
		//Print the location to console
		NSLog(@"First placeMark at %@",locatedAt);
		
		//Set the label text to current location
		self.userCurrentLocationPoint.subtitle = locatedAt;
	}];
	
    [self.mapView addAnnotation:self.userCurrentLocationPoint];
}

#pragma mark - Buttons

-(IBAction)pasteButtonPressed{
	UIPasteboard *pb = [UIPasteboard generalPasteboard];
	self.noteTextView.text = [pb string];
}


@end
