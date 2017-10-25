//
//  SearchCityPage.h
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/19.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCityPage : UIViewController
@property(nonatomic, copy) void (^block)(NSString *);
@property(nonatomic, copy) NSString *selectedCity;
@end
