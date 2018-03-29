//
//  HJEditPersonDataVC.m
//  Apws
//
//  Created by zhipeng-mac on 15/12/22.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJEditPersonDataVC.h"
#import "JKCustomAlertView.h"
#import "HJAddressManagerTVC.h"
#import "HJGetUserInfoAPI.h"
#import "HJUserIcoAPI.h"
#import "HJUpdateUserNameAPI.h"
#import "HJAlterPasswordVC.h"
#import "HJAlertNameView.h"
#import "HJAlterPhotoView.h"
@interface HJEditPersonDataVC ()

@end

@implementation HJEditPersonDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    
    self.cellHeadImageView.lh_left = SCREEN_WIDTH - 60;
    self.cellHeadImageView.image = [UIImage imageNamed:@"ic_touxiang"];
    
    WEAK_SELF();
    self.updateIconAction = ^(UIImage *image) {

        if (image) {
            
            NSData *iconData = UIImageJPEGRepresentation(image, 0.3);
            
            [weakSelf userIconRequestWithIconData:iconData];
        }
        
    };
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getUserInfoRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJGetUserInfoAPI class]]) {
        
        HJGetUserInfoAPI *apiModel = responseObject;
        
        NSArray *allSettingItems = [self allSettingItems];
        
        HJSettingItem *headImageItem = [allSettingItems objectAtIndex:0];
        headImageItem.image = apiModel.data.userIco;
        HJSettingItem *nameItem = [allSettingItems objectAtIndex:1];
        nameItem.detailTitle = apiModel.data.userName;
    
        
        [self.cellHeadImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(apiModel.data.userIco)] placeholderImage:kImageNamed(@"ic_touxiang")];
        
        [self.tableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJUpdateUserNameAPI class]]) {
        
        [self getUserInfoRequest];
    }
    
}

#pragma mark - Actions
- (void)takePhotoAction
{
    // 拍照
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (void)selectPhotoAction
{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}


#pragma mark - Methods

- (void)updateUserName:(NSString *)userName {
    
    
}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    [super getMediaFromSource:sourceType];
}


#pragma mark -Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        
        return 64;
    }else {
        
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case 0:
        {
            HJAlterPhotoView *alertPhotoView = [HJAlterPhotoView alterPhotoView];
            [self.view.window addSubview:alertPhotoView];
            alertPhotoView.alertType = HJAlertTypePersonPhoto;
            [alertPhotoView.takePhotoButton addTarget:self action:@selector(takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
            [alertPhotoView.selectPhotoButton addTarget:self action:@selector(selectPhotoAction) forControlEvents:UIControlEventTouchUpInside];
        }
            
            break;
            
        case 1:
        {
            WEAK_SELF();
            HJAlertNameView *alertNameView = [HJAlertNameView alertNameView];
            [weakSelf.view addSubview:alertNameView];
            alertNameView.nameString = ^(NSString *nameString){
                [weakSelf updateUserNameRequestWithUserName:nameString];
            };
        }
            
            break;
        case 2:
        {
            
            HJAddressManagerTVC *addressManagerTVC = [HJAddressManagerTVC new];
            [self.navigationController lh_pushVC:addressManagerTVC];
        }
            break;
        case 3:
        {
            HJAlterPasswordVC *alterPasswordVC = [[HJAlterPasswordVC alloc] init];
            [self.navigationController lh_pushVC:alterPasswordVC];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - NewWorking Request

- (void)getUserInfoRequest {
    
    [[[HJGetUserInfoAPI getUserInfo]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)userIconRequestWithIconData:(NSData *)iconData {
    
    [[[HJUserIcoAPI userIco_ico:iconData] netWorkClient] uploadFileInView:self.view successBlock:^(id responseObject) {
        
        HJUserIcoAPI *api = responseObject;
        
        if (api.code == NetworkCodeTypeSuccess) {
            
            [self getUserInfoRequest];
        }
    }];
}

- (void)updateUserNameRequestWithUserName:(NSString *)userName {
    
    [[[HJUpdateUserNameAPI updateUserName_userName:userName]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter_Getter

- (NSArray *)groupTitles {
    
    return @[ @[@"头像",@"昵称",@"我的地址",@"修改密码"]];
}

- (NSArray *)groupDetials {
    
    return @[ @[@"",@"",@"",@""]];
}

- (NSIndexPath *)headImageCellIndexPath {
    
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (NSArray *)indicatorIndexPaths {
    
    return @[ [NSIndexPath indexPathForRow:1 inSection:0],
              [NSIndexPath indexPathForRow:2 inSection:0],
              [NSIndexPath indexPathForRow:3 inSection:0] ];
}

@end
