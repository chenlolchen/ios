//
//  FormTextCell.h
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/17.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormTextCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *arrow;
@property (strong, nonatomic) IBOutlet UILabel *formLabel;
@property (strong, nonatomic) IBOutlet UITextField *formTextField;

@end
