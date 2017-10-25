//
//  SexPickerView.h
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, copy) void(^block)(NSString *);
@property (nonatomic, copy) void(^cancelBlock)();
@end
