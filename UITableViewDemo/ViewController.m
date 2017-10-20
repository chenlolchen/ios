//
//  ViewController.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/16.
//  Copyright © 2017 CODY. All rights reserved.
//

#import "ViewController.h"
#import "Friend.h"
#import "DemoCell.h"
#import "RegisterController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define indexPathInterval 9999

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *tableDataArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"User Name";
    tableDataArray = [self tableDataSource];

//
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight)];
//    tableView.dataSource = self;
//    tableView.delegate = self;
//    tableView.estimatedRowHeight = 200;
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    [tableView registerNib:[UINib nibWithNibName:@"DemoCell" bundle:nil] forCellReuseIdentifier:@"DemoCell"];
//    tableView.rowHeight=100;
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"DemoCell" bundle:nil] forCellReuseIdentifier:@"DemoCellID"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
}

- (NSArray *)tableDataSource{
    NSURL *url = [NSURL URLWithString:@"http://10.222.225.32:8080/customers"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"NSURLResponse: %@", response);
        NSLog(@"NSData: %@", data);
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        for(NSDictionary *dictionary in array){
            NSLog(@"dictionary = %@", dictionary);
        }
    }];

    [task resume];

    NSArray *nameArray = @[@"xiaoming",@"cody",@"chenjf",@"lol", @"xiaohong", @"xiaomao", @"xiaogou"];
    NSArray *textArray = @[@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊",@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊2",@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊3",@"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊4",@"巴巴爸爸不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不不少时诵诗书所所所所所所所所所所所所所所所",@"ehdaisdjiwqjiqjiasjdkasndkanskdnakndqkwnkqnwkqnkq",@"阿萨德"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < nameArray.count; ++i) {
        Friend *friend = [[Friend alloc] init];
        friend.name = nameArray[i];
        friend.image = [UIImage imageNamed:@"userImage.png"];
        friend.isFavorite = false;
//        if(i % 2 == 0){
//            friend.image = [UIImage imageNamed:@"test.jpg"];
//            friend.isFavorite = true;
//        } else {
//            friend.image = [UIImage imageNamed:@"user.png"];
//            friend.isFavorite = false;
//        }
        friend.messageLabel = textArray[i];
        friend.date = [NSDate date];
        [array addObject:friend];
    }
//    for(NSString *item in nameArray){
//        Friend *mfriend = [[Friend alloc] init];
//        mfriend.name = item;
//        if(i){
//            mfriend.image = [UIImage imageNamed:@"test.jpg"];
//        } else {
//            mfriend.image = [UIImage imageNamed:@"user.png"];
//        }
//        mfriend.webUrl = @"www.baidu.com";
//        [array addObject:mfriend];
//    }
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"www.baidu.com.searchDemo";
//    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//
//    if(cell == nil){
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"DemoCell" owner:nil options:nil] firstObject];
////        cell = [[DemoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//    }
//
//    cell.autoresizesSubviews = TRUE;

//    Friend *friendCell = (Friend *)[tableDataArray objectAtIndex:indexPath.row];
//    cell.imageView.image = friendCell.image;
//    cell.textLabel.text = friendCell.name;
//    cell.detailTextLabel.text = friendCell.webUrl;

    DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCellID" forIndexPath:indexPath];

    [cell.starButton setTitle:@"" forState:UIControlStateNormal];
    [cell.starButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.starButton addTarget:self action:@selector(clickStar:) forControlEvents:UIControlEventTouchDown];

    cell.starButton.tag = indexPath.row + indexPathInterval;
    cell.friend = tableDataArray[indexPath.row];
    return cell;
}

// 通过view来找
- (void)clickStar:(UIButton *)btn {
    UIView *contentView = [btn superview];
    DemoCell *cell = (DemoCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    NSLog(@"%@----%@",indexPath, tableDataArray[indexPath.row]);
    Friend *friend = tableDataArray[indexPath.row];
    NSLog(@"friend name is : %@", friend.name);

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Demo"
                                                                             message:@"Are you sure to change the favorite"
                                                                      preferredStyle:UIAlertControllerStyleAlert ];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler: nil];
    [alertController addAction:cancelAction];

    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:(void (^)(UIAlertAction *))^{
        friend.isFavorite = !friend.isFavorite;
        cell.friend = friend;
    }];
    [alertController addAction:OKAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

// 通过tag来找
//- (void)clickStar:(UIButton *)btn{
//    Friend *friend = (Friend *)tableDataArray[btn.tag - indexPathInterval];
//
//    UIView *contentView = [btn superview];
//    DemoCell *cell = (DemoCell *)[contentView superview];
//    NSLog(@"%ld ------- %@", btn.tag - indexPathInterval, friend.name);
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有标题的标题"
//                                                                             message:@"学无止境，漫漫长路"
//                                                                      preferredStyle:UIAlertControllerStyleAlert ];
//
//    //添加取消到UIAlertController中
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler: (void (^)(UIAlertAction *))^{
//            NSLog(@"cancel ..");
//        }];
//    [alertController addAction:cancelAction];
//
//    //添加确定到UIAlertController中
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:(void (^)(UIAlertAction *))^{
//        NSLog(@"ok ..");
//        friend.name = @"cody";
//        cell.friend = friend;
////        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    }];
//    [alertController addAction:OKAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];
//}

//- (void)clickStar:sender {
//    NSLog(@"test ...%@",sender);
//    NSLog(@"sender");
////    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"aaa" preferredStyle:UIAlertControllerStyleAlert];
////    [self presentViewController:alert animated:YES completion:nil];
//}


@end
