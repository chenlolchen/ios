//
// Created by CHENCO7 on 2017/11/3.
// Copyright (c) 2017 CODY. All rights reserved.
//

#import "CustomerNavigationViewController.h"


@implementation CustomerNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

-(BOOL)shouldAutorotate{
    NSLog(@"[[self.viewControllers lastObject] shouldAutorotate] ===== %@", @([[self.viewControllers lastObject] shouldAutorotate]));
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end