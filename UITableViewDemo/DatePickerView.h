//
//  DatePickerView.h
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017 CODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property(nonatomic, copy) void (^block)(NSString *);
@property(nonatomic, copy) void (^cancelBlock)();
@end
