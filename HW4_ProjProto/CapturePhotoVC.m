//
//  CapturePhotoVC.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/11/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "CapturePhotoVC.h"

@interface CapturePhotoVC ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UIImagePickerController *photoPickerController;


@end

@implementation CapturePhotoVC

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Button


- (IBAction)choosePictureFromPhotoAlbumPressed:(UIButton *)sender {
	self.photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self.photoPickerController setAllowsEditing:YES];
	self.photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:self.photoPickerController animated:true completion:nil];
}

- (IBAction)takePicturePressed:(UIButton *)sender {
	if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
		self.photoPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self.photoPickerController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
		[self.photoPickerController setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
		[self.photoPickerController setShowsCameraControls:YES];
		[self.photoPickerController setAllowsEditing:YES];
		
//		self.cameraOverlayView = [[UIView alloc]initWithFrame:self.view.frame];
//		[self.cameraOverlayView setUserInteractionEnabled:false];
//		self.cameraOverlayView.backgroundColor = [UIColor clearColor];
//		UIButton * changeSource = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		changeSource.backgroundColor = [UIColor clearColor];
//		changeSource.titleLabel.backgroundColor = [UIColor clearColor];
//		changeSource.titleLabel.textColor = [UIColor blackColor];
//		changeSource.alpha=0.5;
//		changeSource.titleLabel.font = [UIFont systemFontOfSize:15];
//		[changeSource setTitle:@"Photo" forState:UIControlStateNormal];
//		[changeSource addTarget:self action:@selector(changeSourceType:) forControlEvents:UIControlEventTouchUpInside];
//		[changeSource setFrame:CGRectMake(130, 385, 60, 35)];
//		[self.cameraOverlayView addSubview:changeSource];

		[self presentViewController:self.photoPickerController animated:true completion:nil];
	}else{
		
		[self choosePictureFromPhotoAlbumPressed:nil];
		
	}
	
}


#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
	
	//save original image to photo album
	if (picker.sourceType!=UIImagePickerControllerSourceTypePhotoLibrary) {
		UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
		UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
	}
	
	//Set image to image view
	NSLog(@"New image scale=%f",image.scale);
	self.photoView.image = image;
	
	//Send image
//	UIImage * correctImage =  [ImageProcessor fixOrientationOfImage:image]; //rotate image by 90 degree 											   
//	PhotoIconMaker * photoIconMaker = [[PhotoIconMaker alloc]initToCreatePhotoIconWithImage:correctImage forPlace:placeName ParentViewController:parentViewController delegate:photoIconMakerDelegate];
//	[parentViewController.view addSubview:photoIconMaker];
//	[self dismissModalViewControllerAnimated:YES];
//	if ([HandyView currentSize].width<=320) {
//		[parentViewController.view setFrame:CGRectMake(0, 20, parentViewController.view.frame.size.width, parentViewController.view.frame.size.height)];
//	}
//	else if (self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
//		[parentViewController.view setFrame:CGRectMake(-20, 0, parentViewController.view.frame.size.width, parentViewController.view.frame.size.height)];
//	}

//	[[UIApplication sharedApplication] setStatusBarHidden:false];
	[self dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker {
	NSLog(@"Photo Picker didCancel!");
	[self dismissViewControllerAnimated:true completion:nil];
//	if (photoIconMakerDelegate) {
//		[photoIconMakerDelegate photoIconMakerDidCancel:nil];
//	}
//	
//	[self dismissModalViewControllerAnimated:YES];
//	if ([HandyView currentSize].width<=320) {
//		[parentViewController.view setFrame:CGRectMake(0, 20, parentViewController.view.frame.size.width, parentViewController.view.frame.size.height)];
//	}
//	else if (self.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
//		[parentViewController.view setFrame:CGRectMake(-20, 0, parentViewController.view.frame.size.width, parentViewController.view.frame.size.height)];
//	}
//	[[UIApplication sharedApplication] setStatusBarHidden:false];

}

@end
