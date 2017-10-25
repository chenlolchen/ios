//
// Created by CHENCO7 on 17/10/25.
// Copyright (c) 2017 CODY. All rights reserved.
//

#import "HttpRequestHelper.h"
#import "User.h"

@interface HttpRequestHelper ()

@end
@implementation HttpRequestHelper
- (void)method:(NSString *)method requestUrl:(NSString *)requestUrl callback:(callback)callback{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"method == %@", method);
        NSLog(@"requestUrl == %@", requestUrl);
        NSURL *url = [NSURL URLWithString:requestUrl];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod: method];

        NSURLSession *session = [NSURLSession sharedSession];

        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{                // 如果不加这句话的时候，会在另外的一个线程回调
                NSLog(@"error : %@", error);
                NSLog(@"response : %@", response);
                if(!error){
                    NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    callback(dataArray);
                }
            });
        }];
        [task resume];
    });
}

@end