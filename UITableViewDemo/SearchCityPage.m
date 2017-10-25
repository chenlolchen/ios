//
//  SearchCityPage.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/19.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "SearchCityPage.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface SearchCityPage () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate> {
    NSMutableArray *dataList;       //全部数据的array
    NSMutableArray *searchList;     //search到的array
}

@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SearchCityPage

- (NSMutableArray *)searchListDataSource {
    NSMutableArray *array = [@[@"Zhu Hai", @"Hong Kong", @"Guang Zhou", @"Bei Jing", @"Shang Hai", @"Shen Zhen", @"Shan Tou"] mutableCopy];
    return array;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"City";
    dataList = [self searchListDataSource];
    searchList = [NSMutableArray arrayWithArray:@[]];
    [self createTableView];
    [self createSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}

- (void)createSearch {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
//    _searchController.searchBar.delegate = self;                    // 设置searchBar的常用方法
    _searchController.dimsBackgroundDuringPresentation = NO;        // 是否添加半透明覆盖层
    _searchController.hidesNavigationBarDuringPresentation = NO;    // 是否隐藏导航栏
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [searchList count];
    } else {
        return [dataList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag = @"searchCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (self.searchController.active) {
        NSLog(@"into table view, selectedCity is : %@, tablecell is : %@", self.selectedCity, searchList[indexPath.row]);
        if ([searchList[indexPath.row] isEqualToString:self.selectedCity]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        [cell.textLabel setText:searchList[indexPath.row]];
    } else {
        if ([dataList[indexPath.row] isEqualToString:self.selectedCity]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        [cell.textLabel setText:dataList[indexPath.row]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.block(cell.textLabel.text);
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"selected ..");
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"updateSearchResultsForSearchController..");
    NSString *searchString = [self.searchController.searchBar text];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (searchList != nil) {
        [searchList removeAllObjects];
    }
    //过滤数据
    searchList = [NSMutableArray arrayWithArray:[dataList filteredArrayUsingPredicate:predicate]];
    //刷新表格
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.searchController.active) {
        [self.searchController dismissViewControllerAnimated:NO completion:nil];
    }
    [super viewWillDisappear:animated];
}

@end
