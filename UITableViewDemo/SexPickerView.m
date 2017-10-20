//
//  SexPickerView.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/18.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "SexPickerView.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface SexPickerView (){
    NSArray *sexArray;
    NSString *sexStr;
}
@property (nonatomic, strong) UIView *pickerUIView;
@end

@implementation SexPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        sexArray = @[@"男", @"女"];
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 200 - 44)];

        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];

        pickerView.delegate = self;
        toolBar.items = @[item1, item2, item3];
        [self addSubview:toolBar];
        [self addSubview:pickerView];
    }

    return self;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    sexStr = sexArray[row];
}


- (void)doneAction {
    if(sexStr == NULL){
        sexStr = sexArray[0];
    }
    if(self.block){
        self.block(sexStr);
    }
    [self removeFromSuperview];
}

- (void)cancelAction {
    if(self.cancelBlock){
        self.cancelBlock();
    }
    [self removeFromSuperview];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return sexArray[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return sexArray.count;
}

@end
