//
//  NewSourceVC.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/8/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "NewSourceVC.h"
#import "AppDelegate.h"

@interface NewSourceVC ()

@property (weak, nonatomic) IBOutlet UITextField *sourceTitle;

@property (weak, nonatomic) IBOutlet UICollectionView *iconCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation NewSourceVC{
	NSArray * iconPath;
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
	// Do any additional setup after loading the view.
	
	
	iconPath = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"iconbeast"];
	//NSLog(@"iconPath=%@",iconPath);
	self.pageControl.numberOfPages = [iconPath count]/30;
	self.pageControl.currentPage = 0;
	[self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - CollectionView datesource and delegate

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return iconPath.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
	static NSString *Icon = @"Icon";
	
	NSString * CellIdentifier = Icon;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
	
	if ([CellIdentifier isEqualToString:Icon]) {
		UIImageView * imageView = (UIImageView*)[cell viewWithTag:1];
		//imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wifi" ofType:@"png" inDirectory:@"iconbeast"]];
		imageView.image = [UIImage imageWithContentsOfFile:[iconPath objectAtIndex:indexPath.row]];
		//need to implement this for highlight selected cell =.=' this should be default, common Apple!
		if (cell.selected)cell.backgroundColor = [UIColor blueColor];
		else cell.backgroundColor = [UIColor whiteColor];
	}
	
	if(indexPath.row % 30==0){
		int currentPage = indexPath.row/30;
		self.pageControl.currentPage = currentPage;
	}
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//	NSLog(@"collection selected %@",indexPath);
	UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
	cell.backgroundColor = [UIColor blueColor];
	
	if(self.sourceTitle.isFirstResponder)[self.sourceTitle resignFirstResponder];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
	UICollectionViewCell *cell =[collectionView cellForItemAtIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
	//this happend when user touch one of the cell but not yet released
	
	if(self.sourceTitle.isFirstResponder)[self.sourceTitle resignFirstResponder];
}

#pragma mark - page control

-(void)pageChanged:(UIPageControl*)sender{
	int row = sender.currentPage * 30;
	[self.iconCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:true];
}

#pragma mark - Textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return NO;
}

#pragma mark - segue, push, pop

- (IBAction)newSourcePressed:(UIBarButtonItem *)sender {
	[self createNewSourceAndPopBack];
}

- (void)createNewSourceAndPopBack{
	NSIndexPath* selectedIndexPath = [self.iconCollectionView.indexPathsForSelectedItems lastObject];
	NSLog(@"seletedIndexPath=%@",selectedIndexPath);
	NSString * iconName = @"";
	if (selectedIndexPath!=NULL) {
		NSString * path = [iconPath objectAtIndex:selectedIndexPath.row];
		iconName = [[path lastPathComponent] stringByDeletingPathExtension];
	}
	
	NSString * title = self.sourceTitle.text;
	
	if (title.length>0) {
		[[(AppDelegate*)[[UIApplication sharedApplication]delegate] dataSystem] addNewSourceWithName:title IconName:iconName];
		[self.navigationController popViewControllerAnimated:true];
	}
	
}



@end
