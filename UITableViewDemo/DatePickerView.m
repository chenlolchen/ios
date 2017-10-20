//
//  DatePickerView.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017 CODY. All rights reserved.
//

#import "DatePickerView.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface DatePickerView (){
    NSDate *selectDate;
}
@property (nonatomic, strong) UIView *pickerUIView;
@end

@implementation DatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 200 - 44)];
        datePicker.datePickerMode = UIDatePickerModeDate;

        [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged | UIControlEventEditingDidBegin | UIControlEventPrimaryActionTriggered | UIControlEventAllEvents];

        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];

        toolBar.items = @[item1, item2, item3];
        [self addSubview:toolBar];
        [self addSubview:datePicker];
    }

    return self;
}

- (void)cancelAction {
    if(self.cancelBlock){
        self.cancelBlock();
    }
    [self removeFromSuperview];
}

- (void)dateChange:(id)sender {
    UIDatePicker *control = (UIDatePicker*)sender;
    selectDate = control.date;
}

- (void)doneAction {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:selectDate];

    if(dateStr == NULL){
        selectDate = [NSDate date];
        dateStr = [formatter stringFromDate:selectDate];
    }

    NSLog(@"date string is : %@", dateStr);
    if(self.block){
        self.block(dateStr);
    }
    [self removeFromSuperview];
}

@end
