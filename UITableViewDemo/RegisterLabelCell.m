//
//  RegisterLabelCell.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "RegisterLabelCell.h"

@implementation RegisterLabelCell
- (instancetype)init {
    self = [super init];
    if (self) {
        self.labelName = [[UILabel alloc] init];
        self.labelText = [UILabel new];
        self.labelText.textAlignment = NSTextAlignmentCenter;
        NSDictionary *views = NSDictionaryOfVariableBindings(self, self.contentView, _labelName, _labelText);
        self.labelText.layer.cornerRadius = 4;
        self.labelText.layer.borderWidth = 1;
        self.labelText.layer.masksToBounds = YES;
        self.labelText.layer.borderColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.00].CGColor;


        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelText];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelText.translatesAutoresizingMaskIntoConstraints = NO;

        NSLog(@"self.contentView height : %@", self.contentView);

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_labelName]-20-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelName]-10-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-200-[_labelText]-20-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_labelText]-5-|" options:0 metrics:nil views:views]];
    }

    return self;
}


//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//        self.labelText = [UILabel new];
//        NSDictionary *views = NSDictionaryOfVariableBindings(self, self.contentView, _labelName, _labelText);
//
//        [self.contentView addSubview:self.labelName];
//        [self.contentView addSubview:self.labelText];
//        self.translatesAutoresizingMaskIntoConstraints = NO;
//        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
//        self.labelText.translatesAutoresizingMaskIntoConstraints = NO;
//
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_labelName]-20-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelName]-10-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_labelText]-75-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelText]-10-|" options:0 metrics:nil views:views]];
//    }
//
//    return self;
//}


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//        self.labelText = [UILabel new];
//        NSDictionary *views = NSDictionaryOfVariableBindings(self, self.contentView, _labelName, _labelText);
//
//        [self.contentView addSubview:self.labelName];
//        [self.contentView addSubview:self.labelText];
//        self.translatesAutoresizingMaskIntoConstraints = NO;
//        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
//        self.labelText.translatesAutoresizingMaskIntoConstraints = NO;
//
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_labelName]-20-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelName]-10-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_labelText]-75-|" options:0 metrics:nil views:views]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_labelText]-10-|" options:0 metrics:nil views:views]];
//    }
//
//    return self;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
