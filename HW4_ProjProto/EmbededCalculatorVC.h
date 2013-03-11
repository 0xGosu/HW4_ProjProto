//
//  ViewController.h
//  RPNCalculator
//
//  Created by V.Anh Tran on 1/19/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


#import "RPNCalculatorBrain.h"



@interface EmbededCalculatorVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;

@end
