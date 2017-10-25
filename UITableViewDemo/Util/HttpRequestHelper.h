//
// Created by CHENCO7 on 17/10/25.
// Copyright (c) 2017 CODY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

typedef void (^callback) (NSArray *array);

@interface HttpRequestHelper : NSObject
-(void)method:(NSString *)method requestUrl:(NSString *)requestUrl callback:(callback)callback;
@end