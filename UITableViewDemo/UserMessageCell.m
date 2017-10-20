//
//  UserMessageCell.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/16.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "UserMessageCell.h"
#import "User.h"

@interface UserMessageCell()

@end

@implementation UserMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"init ...");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(User *)user {
    NSLog(@"set model ...");

    self.nameLabel.text = user.name;
    self.userImage.image = [UIImage imageNamed:user.image];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:user.date];
    if(user.isFavorite){
        self.starImage.image = [UIImage imageNamed:@"yellowstar.png"];
    }else {
        self.starImage.image = [UIImage imageNamed:@"graystar.png"];
    }
    self.messageLabel.text = user.messageLabel;
}

@end
