//
//  HJWishWallTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWishWallTVC.h"
#import "HJTextFieldCell.h"
#import "XYQPlaceholderTextVIew.h"
#import "HJIconImageViewCell.h"
#import "ZLPickerViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "HJWishAPI.h"
#import "HJAlterPhotoView.h"
#import "HJSaleResultVC.h"

static NSString * const kContactWay = @"联系方式：";
static NSString * const kGoodsName =  @"商品名称：";
static NSString * const kGoodsBrand = @"商品品牌：";
static NSString * const kCompanyTelphone = @"厂家电话：";
static NSString * const kInputContent = @"请输入内容";
static NSUInteger kMaxSelectImageCount = 3;

@interface HJWishWallTVC () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,ZLPickerViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) NSMutableArray *selectImages;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) XYQPlaceholderTextVIew *contentTextView;
@property (nonatomic, weak) UILabel *warnLabel;
@property (nonatomic, weak) HJAlterPhotoView *alterPhotoView;

@end

@implementation HJWishWallTVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"心愿墙";
    
    self.view.backgroundColor = kWhiteColor;
    
    [self.tableView lh_registerClassFromCellClassName:[HJTextFieldCell className]];
    
    [self buildTableFooterView];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJTextFieldCell className]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.settingItem = [self.tableItems objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.TextFieldCellType = HJTextFieldCellTypePhone;
        cell.detailTextField.placeholder = @"(必填)";
    }
    
    if (indexPath.row == 4) {
        
        cell.detailTextField.userInteractionEnabled = NO;
    } else {
        
        cell.detailTextField.userInteractionEnabled = YES;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (self.selectImages.count == kMaxSelectImageCount) ? kMaxSelectImageCount : self.selectImages.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HJIconImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJIconImageViewCell className] forIndexPath:indexPath];
    
    if (indexPath.row == self.selectImages.count) {
        
        cell.iconImageView.image = [UIImage imageNamed:@"ic_b5_01"];
        cell.deleleButton.hidden = YES;
        
        [self addWarningText:cell];
    } else {
        
        cell.deleleButton.tag = indexPath.row;
        [cell.deleleButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.iconImageView.image = [self.selectImages objectAtIndex:indexPath.row];
        cell.deleleButton.hidden = NO;
        
        if (self.selectImages.count == kMaxSelectImageCount) {
            [self.warnLabel removeFromSuperview];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self addimageAction];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthScaleSize(65),WidthScaleSize(65));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(20, 20, 0, 0);
    } else {
        return UIEdgeInsetsMake(20, 0, 0, 0);
    }
    
}

#pragma mark - Actions

- (void)commitWishAction {
    
    //
    HJSettingItem *userPhoneItem = [self.tableItems objectAtIndex:0];
    HJSettingItem *goodsNameItem = [self.tableItems objectAtIndex:1];
    HJSettingItem *brandNameItem = [self.tableItems objectAtIndex:2];
    HJSettingItem *phoneItem = [self.tableItems objectAtIndex:3];
    
    if (!userPhoneItem.inputString.length) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
        return;
    }
    
    if (![userPhoneItem.inputString lh_isValidateMobile]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    //图片数组
    NSMutableArray *icoDatas = [NSMutableArray array];
    [self.selectImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = obj;
        
        [icoDatas addObject:UIImageJPEGRepresentation(image, 0.3)];
    }];
    
    [[[HJWishAPI wish_userPhone:userPhoneItem.inputString?:kEmptySrting goodsName:goodsNameItem.inputString?:kEmptySrting brandName:brandNameItem.inputString?:kEmptySrting phone:phoneItem.inputString?:kEmptySrting content:self.contentTextView.text?:kEmptySrting ico:icoDatas]netWorkClient]uploadFileInView:self.view successBlock:^(id responseObject) {
        
        HJWishAPI *api = responseObject;
        
        if (api.code == NetworkCodeTypeSuccess) {
            
            HJSaleResultVC *resultVC = [[HJSaleResultVC alloc] init];
            
            [self.tableItems enumerateObjectsUsingBlock:^(HJSettingItem  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.inputString = nil;
            }];
            [self.selectImages removeAllObjects];
            self.contentTextView.text = nil;
            [self.tableView reloadData];
            [self.photoCollectionView reloadData];
            
            resultVC.resultType = HJResultTypeWish;
            [self.navigationController lh_pushVC:resultVC];
        }
    }];
}

- (void)addimageAction {
    [self.view endEditing:YES];
    
    HJAlterPhotoView *alterPhotoView = [HJAlterPhotoView alterPhotoView];
    [alterPhotoView.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [alterPhotoView.selectPhotoButton addTarget:self action:@selector(localPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:alterPhotoView];
    self.alterPhotoView = alterPhotoView;
}

- (void)deleteImageAction:(UIButton *)button
{
    [self.selectImages removeObjectAtIndex:button.tag];
    [self.photoCollectionView reloadData];
}

#pragma mark - Methods

- (void)addWarningText:(HJIconImageViewCell *)cell
{
    [self.warnLabel removeFromSuperview];
    UILabel *warnLabel = [UILabel lh_labelAdaptionWithFrame:CGRectMake(CGRectGetMaxX(cell.frame) + 5, CGRectGetMaxY(cell.frame) - 20, 70, 20) text:@"插入图片" textColor:kBlackColor font:FONT(13) textAlignment:NSTextAlignmentLeft];
    self.warnLabel = warnLabel;
    [self.photoCollectionView addSubview:warnLabel];
}

- (void)buildTableFooterView {
    
    UIView *footerView = [UIView lh_viewWithFrame:CGRectZero backColor:kWhiteColor];
    
    XYQPlaceholderTextVIew *textView = [[XYQPlaceholderTextVIew alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 115)];
    textView.backgroundColor = kVCBackGroundColor;
    textView.font = FONT(15);
    textView.placeholder = @"您可以拍照或者文字说明您的具体需求。";
    [footerView addSubview:textView];
    self.contentTextView = textView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    UICollectionView *photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, textView.lh_bottom, kScreenWidth, 120) collectionViewLayout:layout];
    photoCollectionView.delegate = self;
    photoCollectionView.dataSource = self;
    [photoCollectionView setBackgroundColor:kWhiteColor];
    [photoCollectionView registerNib:[UINib nibWithNibName:[HJIconImageViewCell className] bundle:nil] forCellWithReuseIdentifier:[HJIconImageViewCell className]];
    
    [footerView addSubview:photoCollectionView];
    self.photoCollectionView = photoCollectionView;
    
    UILabel *noteLabel = [UILabel lh_labelAdaptionWithFrame:CGRectMake(15, photoCollectionView.lh_bottom, kScreenWidth - 30, 10) text:@"很抱歉，我们没能满足您的需求，但是这都不重要，这里是我们的心愿墙，您有什么需要尽管在这里提就是。我们都能尽最大的能力满足您的需求。" textColor:kFontGrayColor font:FONT(13) textAlignment:NSTextAlignmentCenter];
    [footerView addSubview:noteLabel];
    
    UIButton *commitButton = [UIButton lh_buttonWithFrame:CGRectMake(15, noteLabel.lh_bottom + 30, kScreenWidth-2*15, 30) target:self action:@selector(commitWishAction) title:@"提交心愿" titleColor:kWhiteColor font:FontNormalSize backgroundColor:kOrangeColor];
    commitButton.layer.cornerRadius = kSmallCornerRadius;
    
    [footerView addSubview:commitButton];
    
    footerView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(commitButton.frame) + 20);
    self.tableView.tableFooterView = footerView;
}

//开始拍照
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        picker.allowsEditing = YES;
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC presentViewController:picker animated:YES completion:nil];
    }
    else {
        
        [UIAlertView lh_showWithMessage:@"当前设备不支持拍摄功能"];
    }
}

//打开本地相册
-(void)localPhoto
{
    ZLPickerViewController *pickerVc = [[ZLPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    pickerVc.maxCount = kMaxSelectImageCount - self.selectImages.count;
    [pickerVc setExceedSelectedImage:^(NSUInteger minCount) {
        NSString *message;
        if (self.selectImages.count == 0) {
            message = [NSString stringWithFormat:@"最多只能选择%zd张图片", minCount];
        }
        else {
            message = [NSString stringWithFormat:@"您之前已选择%zd张图片，现在最多能选择%zd张图片", kMaxSelectImageCount - minCount, minCount];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alertView show];
    }];
    [pickerVc setDismissBlock:^{
    }];
    [pickerVc show];
}


- (HJSettingItem *)buildSettingItemWithTitle:(NSString *)title {
    
    HJSettingItem *settingItem = [HJSettingItem new];
    settingItem.title = title;
    
    return settingItem;
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{

            if (self.selectImages.count <kMaxSelectImageCount) {
                
                [self.selectImages addObject:image];
                [self.photoCollectionView reloadData];
  
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    picker.delegate = nil;
    picker = nil;
}

#pragma mark - <ZLPickerViewControllerDelegate>

/**
 *  返回所有的Asstes对象
 */
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets {
    NSMutableArray *images = [NSMutableArray array];
    
    [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALAsset *asset = obj;
        //        CGImageRef imageRef = asset.thumbnail;// {157, 157}
        CGImageRef imageRef = asset.aspectRatioThumbnail;// {256, 384}
        //        CGImageRef imageRef = [[asset defaultRepresentation] fullResolutionImage];// {1280, 850}
        //        CGImageRef imageRef = [[asset defaultRepresentation] fullScreenImage];// {960, 637}
        UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
        [images addObject:image];
    }];
    
    [self.selectImages addObjectsFromArray:images];
    [self.photoCollectionView reloadData];
}

#pragma mark - Setter&Getter

- (NSArray *)tableItems {
    
    if (!_tableItems) {
        
        NSMutableArray *tableItems = [NSMutableArray array];
        
        NSArray *itemTitles = @[kContactWay,kGoodsName,kGoodsBrand,kCompanyTelphone,kInputContent];
        
        [itemTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *title = obj;
            [tableItems addObject:[self buildSettingItemWithTitle:title]];
        }];
        
        _tableItems = tableItems;
    }
    
    return _tableItems;
}

- (NSMutableArray *)selectImages {
    
    if (!_selectImages) {
        
        _selectImages = [NSMutableArray array];
    }
    
    return _selectImages;
}

@end
