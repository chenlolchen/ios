//
//  DemoCell.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/16.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "DemoCell.h"
#import "Friend.h"

@interface DemoCell()

@end

@implementation DemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"init ...");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFriend:(Friend *)friend{
    NSLog(@"set model ...");

    self.nameLabel.text = friend.name;
    self.userImage.image = friend.image;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [dateFormatter stringFromDate:friend.date];
    if(friend.isFavorite){
        self.starImage.image = [UIImage imageNamed:@"yellowstar.png"];
    }else {
        self.starImage.image = [UIImage imageNamed:@"graystar.png"];
    }
    self.messageLabel.text = friend.messageLabel;
}

@end
