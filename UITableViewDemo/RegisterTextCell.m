//
//  RegisterTextCell.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "RegisterTextCell.h"

@implementation RegisterTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelText = [[UITextField alloc] init];
        _labelText.borderStyle = UITextBorderStyleRoundedRect;
        _labelName = [[UILabel alloc] init];
        NSDictionary *views = NSDictionaryOfVariableBindings(self, self.contentView, _labelText, _labelName);
        self.labelText.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:_labelName];
        [self.contentView addSubview:_labelText];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _labelName.translatesAutoresizingMaskIntoConstraints = NO;
        _labelText.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_labelName]-20-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelName]-10-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-180-[_labelText]-20-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_labelText]-5-|" options:0 metrics:nil views:views]];
    }

    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
