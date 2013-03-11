//
//  FlowCell.h
//  HW4_ProjProto
//
//  Created by V.Anh Tran on 3/9/13.
//  Copyright (c) 2013 V.Anh Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowCell : UITableViewCell

@property(nonatomic) int flowID;

@property (weak, nonatomic) IBOutlet UIImageView *fromSourceIcon;
@property (weak, nonatomic) IBOutlet UIImageView *toSourceIcon;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
