//
//  DemoCell.h
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/16.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Friend;

@interface DemoCell : UITableViewCell
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UIButton *starButton;
@property(strong, nonatomic) IBOutlet UIImageView *starImage;
@property(strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property(strong, nonatomic) Friend *friend;
@end
