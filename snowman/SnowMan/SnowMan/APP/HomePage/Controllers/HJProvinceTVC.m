//
//  HJProvinceTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJProvinceTVC.h"
#import "HJAreaModel.h"
#import "HJAreaListAPI.h"

@interface HJProvinceTVC ()


@end

@implementation HJProvinceTVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择地址";

    [self.tableView lh_registerClassFromCellClassName:[UITableViewCell className]];
    
    [self readAreaDataFromMainBundleBaseOnChooseAreaType];
}

#pragma mark - HJDataHandlerProtocol

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJAreaListAPI class]]) {
        
        HJAreaListAPI *api = responseObject;
        
        self.dataSource = api.data.mutableCopy;
        
        [self.tableView reloadData];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


#pragma mark - Actions



#pragma mark - Methods

- (void)readAreaDataFromMainBundleBaseOnChooseAreaType {
    
//    //地区xml转换
//    NSString *filePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"my_province_data.xml"];
//    NSString *xmlStr = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
//    NSDictionary *xmlDictionary = [NSDictionary dictionaryWithXML:xmlStr];
//    NSLog(@"root=%@",[xmlDictionary objectForKey:@"_name"]);
//    
//    HJAearRootModel *areaModel = [HJAearRootModel mj_objectWithKeyValues:xmlDictionary];
//    
//    if (self.areaChooseType == HJAreaChooseTypeProvince) {
//        
//        self.dataSource = [areaModel.province copy];
//    }
//    if (self.areaChooseType == HJAreaChooseTypeProvince) {
    
        [self areaListRequest];
//    }
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    
    NSString *areaName;
    HJAreaListModel * model = [self.dataSource objectAtIndex:indexPath.row];
    areaName = model.areaName;
    
    cell.textLabel.text = areaName;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.areaChooseType == HJAreaChooseTypeProvince && self.untilChooseType >= HJAreaChooseTypeCity) {
        
        HJProvinceTVC *areaTVC = [HJProvinceTVC new];
        
        areaTVC.areaChooseType = HJAreaChooseTypeCity;
        areaTVC.untilChooseType = self.untilChooseType;
        HJAreaListModel *areaListModel = [self.dataSource objectAtIndex:indexPath.row];
        areaTVC.areaId = areaListModel.areaId;
        areaTVC.province = areaListModel.areaName;
        [self.navigationController lh_pushVC:areaTVC];
        
    }
    
    if (self.areaChooseType == HJAreaChooseTypeCity&& self.untilChooseType >= HJAreaChooseTypeDistrict) {
        
        HJProvinceTVC *areaTVC = [HJProvinceTVC new];
        
        areaTVC.areaChooseType = HJAreaChooseTypeDistrict;
        areaTVC.untilChooseType = self.untilChooseType;
        HJAreaListModel *areaListModel = [self.dataSource objectAtIndex:indexPath.row];
        areaTVC.areaId = areaListModel.areaId;
        areaTVC.province = self.province;
        areaTVC.city = areaListModel.areaName;
        
        [self.navigationController lh_pushVC:areaTVC];
    }
    
    //回首页根控制器
    if (self.areaChooseType == HJAreaChooseTypeCity&& self.untilChooseType == HJAreaChooseTypeCity) {
        
        HJAreaListModel *areaListModel = [self.dataSource objectAtIndex:indexPath.row];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotification_ChangeLocationCity object:areaListModel.areaName];
        
        [self.navigationController lh_popToRootVC];
        
    }

    //回编辑地址控制器
    if (self.areaChooseType == HJAreaChooseTypeDistrict) {
        
        HJAreaListModel *areaListModel = [self.dataSource objectAtIndex:indexPath.row];
        self.district = areaListModel.areaName;
        
        NSString *recieveGoodsArea = [[self.province stringByAppendingString:self.city]stringByAppendingString:self.district];
        
        HJAreaListModel *recieveAddressModel = [HJAreaListModel new];
        recieveAddressModel.areaId = areaListModel.areaId;
        recieveAddressModel.areaName = recieveGoodsArea;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotification_ChangeRecieveGoodsAearCity object:recieveAddressModel];
        
        NSArray *stackVCs = self.navigationController.viewControllers;
        [stackVCs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIViewController *vc = obj;
            
            if ([obj isKindOfClass:NSClassFromString(@"HJEditAddressTVC")]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - Networking Request

- (void)areaListRequest {
    
    [[[HJAreaListAPI areaList_areaId:self.areaId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter


@end
