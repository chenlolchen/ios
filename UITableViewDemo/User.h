//
// Created by CHENCO7 on 17/10/16.
// Copyright (c) 2017 CODY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSString *messageLabel;
@property(nonatomic) bool isFavorite;
@end