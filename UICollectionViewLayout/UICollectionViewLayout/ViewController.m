//
//  ViewController.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "WaterFallViewController.h"
#import "ScalItemViewController.h"
#import "CirlcleItemViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"左对齐",@"瀑布流",@"缩放",@"圆环"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = self.view.backgroundColor;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:tableView];
    
    
    [self clearKeyChain];
    
}


- (void)clearKeyChain {
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                  (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                  nil];
    NSArray *secItemClasses = [NSArray arrayWithObjects:
                               (__bridge id)kSecClassGenericPassword,
                               (__bridge id)kSecClassInternetPassword,
                               (__bridge id)kSecClassCertificate,
                               (__bridge id)kSecClassKey,
                               (__bridge id)kSecClassIdentity,
                               nil];
    for (id secItemClass in secItemClasses) {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        if (result != NULL) CFRelease(result);
        
        NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
        SecItemDelete((__bridge CFDictionaryRef)spec);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0){
        MainViewController *vc = [[MainViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        WaterFallViewController *vc = [[WaterFallViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2)
    {
        ScalItemViewController *vc = [[ScalItemViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        CirlcleItemViewController *vc = [[CirlcleItemViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
