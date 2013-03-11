//
//  FlowCell.m
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/9/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import "FlowCell.h"
#import "AppDelegate.h"

@implementation FlowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFlowID:(int)flowID{
	AppDelegate * app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
	int fromSourceID = [app.dataSystem getFromSourceIDOfFlowWithID:flowID];
	int toSourceID = [app.dataSystem getToSourceIDOfFlowWithID:flowID];
	double amount = [app.dataSystem getAmountOfFlowWithID:flowID];
	
	self.fromSourceIcon.image = [app.dataSystem getIconOfSourceWithID:fromSourceID];
	self.toSourceIcon.image = [app.dataSystem getIconOfSourceWithID:toSourceID];
	
	self.titleLabel.text = [NSString stringWithFormat:@"%@ >> %@",[app.dataSystem getNameOfSourceWithID:fromSourceID]
	,[app.dataSystem getNameOfSourceWithID:toSourceID] ];
	self.detailLabel.text = [NSString stringWithFormat:@"%.2f",amount ];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
