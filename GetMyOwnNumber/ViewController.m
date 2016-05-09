//
//  ViewController.m
//  GetMyOwnNumber
//
//  Created by 66 on 16/5/9.
//  Copyright © 2016年 66. All rights reserved.
//

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "ViewController.h"

extern NSString *CTSettingCopyMyPhoneNumber();


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  CTTelephonyNetworkInfo *networkInfo;

@end

@implementation ViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];

    [self.view addSubview:self.tableView];

    NSString *number = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];

    NSLog(@"get my number %@  %@  ", number, [ViewController myNumber]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTCarrier *carrier = self.networkInfo.subscriberCellularProvider;

    static NSString *CellIdentifier = @ "Cell" ;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }

    switch (indexPath.row) {

        case 0 : //供应商名称（中国联通 中国移动）

            cell.textLabel.text = @ "供应商名称" ;

            cell.detailTextLabel.text = carrier.carrierName;

            break ;

        case 1 : //所在国家编号

            cell.textLabel.text = @ "所在国家编号" ;

            cell.detailTextLabel.text = carrier.mobileCountryCode;

            break ;

        case 2 : //供应商网络编号

            cell.textLabel.text = @ "供应商网络编号" ;

            cell.detailTextLabel.text = carrier.mobileNetworkCode;

            break ;

        case 3 :

            cell.textLabel.text = @ "ISO国家代码" ;

            cell.detailTextLabel.text = carrier.isoCountryCode;

            break ;

        case 4 : //是否允许voip

            cell.textLabel.text = @ "是否允许voip" ;
            
            cell.detailTextLabel.text = carrier.allowsVOIP?@ "YES" :@ "NO" ;
            
            break ;

        default :
            
            break ;
            
    }
    
    
    
    return cell;
}

#pragma mark - 

+(NSString *)myNumber{
    return CTSettingCopyMyPhoneNumber();
}

#pragma mark - Setter Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (CTTelephonyNetworkInfo *)networkInfo {
    if (_networkInfo == nil) {
        _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    }
    return _networkInfo;
}

@end
