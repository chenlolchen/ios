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
#import "RegisterController.h"
#import "HttpRequestHelper.h"
#import "Masonry.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
static NSString *cellId = @"UserMessageCellID";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *tableDataArray;
    HttpRequestHelper *_httpRequestHelper;
}
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"exit viewWillAppear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _httpRequestHelper = [[HttpRequestHelper alloc] init];

    self.title = @"User Name";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    [self createTableView];
    [self loadData];
    [self checkLogin];
    NSLog(@"exit viewDidLoad");
}


- (BOOL)shouldAutorotate{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)checkLogin {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] == @NO) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Demo"
                                                                                 message:@"您还没登录，请先登录后再操作"
                                                                          preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:(void (^)(UIAlertAction *)) ^{
            RegisterController *registerController = [[RegisterController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registerController];
            [navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.27 green:0.64 blue:0.99 alpha:1.00]];
            [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

            [self presentViewController:navigationController animated:YES completion:nil];
        }];
        [alertController addAction:OKAction];

        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)logout {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Demo"
                                                                             message:@"您是否要退出"
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:(void (^)(UIAlertAction *)) ^{
        [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"isLogin"];
        RegisterController *registerController = [[RegisterController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:registerController];
        [navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.27 green:0.64 blue:0.99 alpha:1.00]];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

        [self presentViewController:navigationController animated:YES completion:nil];
    }];
    [alertController addAction:OKAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loadData {
    [_httpRequestHelper method:@"GET" requestUrl:@"http://10.222.225.32:8080/users" callback:^(NSArray *dataArray) {
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
    }];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"UserMessageCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.offset(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count = %d", tableDataArray.count);
    return tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"333");

//    forIndexPath:indexPath 需要注册才能使用
//    UserMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//    if(cell == nil){
//        cell = [[UserMessageCell alloc] init];
//    }

    UserMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//    UserMessageCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserMessageCell" owner:nil options:nil] lastObject];

//    if(indexPath.row == 1){
//        cell.backgroundColor = [UIColor redColor];
//    }
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
