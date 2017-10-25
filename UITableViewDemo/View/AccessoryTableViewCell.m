//
//  AccessoryTableViewCell.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "AccessoryTableViewCell.h"

@implementation AccessoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"aaaaa");
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.labelText = [UITextField new];
        self.labelText.textAlignment = NSTextAlignmentCenter;
        NSDictionary *views = NSDictionaryOfVariableBindings(self, self.contentView, _labelName, _labelText);

        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelText];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelText.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_labelName(120)]-20-[_labelText]-0-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelName]-10-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_labelText]-5-|" options:0 metrics:nil views:views]];
    }

    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
