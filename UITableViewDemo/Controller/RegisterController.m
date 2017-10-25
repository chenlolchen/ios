//
//  RegisterController.m
//  UITableViewDemo
//
//  Created by CHENCO7 on 17/10/17.
//  Copyright © 2017年 CODY. All rights reserved.
//

#import "RegisterController.h"
#import "DatePickerView.h"
#import "RegisterTextCell.h"
#import "AccessoryTableViewCell.h"
#import "SexPickerView.h"
#import "SearchCityPage.h"
#import "RegisterObject.h"
#import "ViewController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height


@interface RegisterController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    NSArray *formLabelArray;
    UITapGestureRecognizer *tap;
    DatePickerView *_datePickerView;
    SexPickerView *_sexPickerView;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *textFieldArray;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Register";
    [self createTableView];
    [self addTapGestureRecognizer];
    [_tableView registerClass:[AccessoryTableViewCell class] forCellReuseIdentifier:@"AccessoryTableViewCell"];
}

- (void)addTapGestureRecognizer {
    self.textFieldArray = [[NSMutableArray alloc] init];            // save the textField index
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];

    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;

    formLabelArray = [self tableDataSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    UIView *tableFooterView = [UIView new];
    tableFooterView.frame = CGRectMake(0, 0, 200, kScreenHeight);

    //Button 按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = [UIColor colorWithRed:0.27 green:0.64 blue:0.99 alpha:1.00];
    registerBtn.frame = CGRectMake((kScreenWidth - 200) / 2, 50, 200, 50);
    registerBtn.layer.cornerRadius = 5.0;
    [tableFooterView addSubview:registerBtn];

    self.tableView.tableFooterView = tableFooterView;

    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
}

- (void)tapView:(id)tapView {
    NSLog(@"UITapGestureRecognizer");
    [self.textFieldArray[0] resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)tableDataSource {
    NSArray *labelArray = @[@"Name", @"Sex", @"Birthday", @"City"];
    NSArray *placeholderArray = @[@"用户名", @"性别", @"生日", @"地址"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < labelArray.count; ++i) {
        RegisterObject *object = [RegisterObject new];
        object.labelText = labelArray[i];
        object.placeholderText = placeholderArray[i];
        [array addObject:object];
    }
    return array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return formLabelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterObject *registerObject = formLabelArray[indexPath.row];

    if ([registerObject.labelText isEqualToString:@"Birthday"] || [registerObject.labelText isEqualToString:@"Sex"] || [registerObject.labelText isEqualToString:@"Name"]) {
        RegisterTextCell *cell = [RegisterTextCell new];
        cell.labelName.text = registerObject.labelText;
        cell.labelText.placeholder = registerObject.placeholderText;
        cell.labelText.keyboardType = UIKeyboardTypeAlphabet;
        [self.textFieldArray addObject:cell.labelText];
        cell.labelText.delegate = self;
        return cell;
    } else {
        AccessoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoryTableViewCell"];
        cell.labelName.text = registerObject.labelText;
        cell.labelText.placeholder = registerObject.placeholderText;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.labelText.delegate = self;
        return cell;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.textFieldArray[0] resignFirstResponder];
    if (_datePickerView) {
        [_datePickerView removeFromSuperview];
        _datePickerView = nil;
    }
    if (_sexPickerView) {
        [_sexPickerView removeFromSuperview];
        _sexPickerView = nil;
    }
    UIView *v = textField.superview;
    NSString *tagName = ((UILabel *) v.subviews[0]).text;
    NSLog(@"select row is ..%@", tagName);
    if ([tagName isEqualToString:@"Sex"]) {
        if (!_sexPickerView) {
            _sexPickerView = [[SexPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
            _sexPickerView.backgroundColor = [UIColor whiteColor];
            _sexPickerView.block = ^(NSString *str) {
                textField.text = str;
            };
            _sexPickerView.cancelBlock = ^() {
                _sexPickerView = nil;
            };
            [self.view resignFirstResponder];
            [self.view addSubview:_sexPickerView];
        }
        return NO;
    } else if ([tagName isEqualToString:@"Birthday"]) {
        if (!_datePickerView) {
            _datePickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
            _datePickerView.backgroundColor = [UIColor whiteColor];
            _datePickerView.block = ^(NSString *str) {
                textField.text = str;
                _datePickerView = nil;
            };
            _datePickerView.cancelBlock = ^() {
                _datePickerView = nil;
            };
            [self.view resignFirstResponder];
            [self.view addSubview:_datePickerView];
        }

        return NO;
    } else if ([tagName isEqualToString:@"City"]) {
        SearchCityPage *searchCityPage = [[SearchCityPage alloc] init];
        searchCityPage.selectedCity = textField.text;

        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
        backButtonItem.title = @"Back";
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationItem.backBarButtonItem = backButtonItem;

        searchCityPage.block = ^(NSString *str) {
            textField.text = str;
        };
        [self.navigationController pushViewController:searchCityPage animated:YES];
        return NO;
    }
    return YES;
}

- (void)registerAction {
    NSArray *cells = [self.tableView visibleCells];
    RegisterTextCell *nameCell = cells[0];
    RegisterTextCell *sexCell = cells[1];
    RegisterTextCell *birthdayCell = cells[2];
    RegisterTextCell *cityCell = cells[3];

    NSLog(@"register ..");
    NSLog(@"nameCell = %@", nameCell.labelText.text);
    NSLog(@"sexCell = %@", sexCell.labelText.text);
    NSLog(@"birthdayCell = %@", birthdayCell.labelText.text);
    NSLog(@"cityCell = %@", cityCell.labelText.text);

    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isLogin"];
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.27 green:0.64 blue:0.99 alpha:1.00]];
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    [self presentViewController:navigationController animated:YES completion:nil];
}

@end