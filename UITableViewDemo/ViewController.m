//
//  ViewController.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/16.
//  Copyright © 2017 CODY. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "UserMessageCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *tableDataArray;
}
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User Name";
    [self createTableView];
    [self loadData];
}

- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"http://10.222.225.32:8080/users"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *dictionary in dataArray) {
                User *user = [User new];
                user.name = dictionary[@"name"];
                user.isFavorite = [dictionary[@"favorite"] boolValue];
                user.messageLabel = dictionary[@"content"];
                user.image = dictionary[@"avatar"];

                NSTimeInterval time = [dictionary[@"date"] doubleValue] / 1000;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
                user.date = date;

                [array addObject:user];
            }
            tableDataArray = array;
            [self.tableView reloadData];
        });
    }];
    [task resume];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserMessageCell" bundle:nil] forCellReuseIdentifier:@"UserMessageCellID"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserMessageCellID" forIndexPath:indexPath];

    [cell.starButton setTitle:@"" forState:UIControlStateNormal];
    [cell.starButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.starButton addTarget:self action:@selector(clickStar:) forControlEvents:UIControlEventTouchDown];

    cell.user = tableDataArray[indexPath.row];
    return cell;
}

// 通过view来找
- (void)clickStar:(UIButton *)btn {
    UIView *contentView = [btn superview];
    UserMessageCell *cell = (UserMessageCell *) [contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    User *user = tableDataArray[indexPath.row];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Demo"
                                                                             message:@"Are you sure to change the favorite"
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];

    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:(void (^)(UIAlertAction *)) ^{
        user.isFavorite = !user.isFavorite;
        cell.user = user;
    }];
    [alertController addAction:OKAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
