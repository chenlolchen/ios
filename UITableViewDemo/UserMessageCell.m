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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"init2222 ...");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    NSLog(@"init ...");
}

- (void)dealloc {
    NSLog(@"UserMessageCell dealloc .");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
