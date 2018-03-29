//
//  HJGoodsCommentCell.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderCommentCell.h"
#import "ZLPickerViewController.h"
#import "HJIconImageViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HJCommentPagAPI.h"
#import "HJAlterPhotoView.h"


static NSUInteger kMaxSelectImageCount = 3;

@interface HJOrderCommentCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate, ZLPickerViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *selectImages;
@property (nonatomic, strong) NSMutableArray *modelImages;
@property (nonatomic, weak) UILabel *warnImageLabel;
@end

@implementation HJOrderCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *ID = @"orderCommentCell";
    HJOrderCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:[HJOrderCommentCell className] owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    self.contentTextView.delegate = self;
    self.commentButton.layer.cornerRadius = kSmallCornerRadius;
    [self.photoCollectionView registerNib:[UINib nibWithNibName:[HJIconImageViewCell className] bundle:nil] forCellWithReuseIdentifier:[HJIconImageViewCell className]];
}


- (void)setOrderCommentModel:(HJOrderCommentModel *)orderCommentModel
{
    _orderCommentModel = orderCommentModel;
    [self.goodsIconView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(orderCommentModel.goodsIco)] placeholderImage:kImageNamed(@"icon_shoplist_default")];
    
    if (orderCommentModel.isComment) {
        self.warnLabel.hidden = YES;
        self.contentTextView.text = orderCommentModel.content;
        self.contentTextView.userInteractionEnabled = NO;
        [self.commentButton setTitle:@"已评价" forState:UIControlStateNormal];
        [self.commentButton setBackgroundColor:kColor214];
        self.commentButton.enabled = NO;
        
    [orderCommentModel.imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HJImageListModel *imageListModel = obj;
        [self.modelImages addObject:imageListModel.imageName];
    }];
        
    } else {
        self.warnLabel.hidden = NO;
        self.contentTextView.userInteractionEnabled = YES;
        self.commentButton.enabled = YES;
    }
}

#pragma mark - Action
- (IBAction)commentButtonClick:(id)sender {
    
    
    if (self.contentTextView.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
    } else {
        NSMutableArray *icoDatas = [NSMutableArray array];
        [self.selectImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *image = obj;
            
            [icoDatas addObject:UIImageJPEGRepresentation(image, 0.3)];
        }];
        [self.delegate orderCommentCellClickComment:self goodId:self.orderCommentModel.Id icoArrayData:icoDatas contentText:self.contentTextView.text];
    }
}

- (void)deleteImageAction:(UIButton *)button
{
    [self.selectImages removeObjectAtIndex:button.tag];
    [self.photoCollectionView reloadData];
}


#pragma mark - Methods


- (void)addWarningText:(HJIconImageViewCell *)cell
{
    [self.warnImageLabel removeFromSuperview];
    UILabel *warnLabel = [UILabel lh_labelAdaptionWithFrame:CGRectMake(CGRectGetMaxX(cell.frame) + 5, CGRectGetMaxY(cell.frame) - 20, 70, 20) text:@"插入图片" textColor:kBlackColor font:FONT(13) textAlignment:NSTextAlignmentLeft];
    self.warnImageLabel = warnLabel;
    [self.photoCollectionView addSubview:warnLabel];
}

- (void)addimageAction {
    
    [self endEditing:YES];
    
    HJAlterPhotoView *alertPhotoView = [HJAlterPhotoView alterPhotoView];
    [alertPhotoView.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [alertPhotoView.selectPhotoButton addTarget:self action:@selector(localPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:alertPhotoView];
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
//    [actionSheet bk_setDidDismissBlock:^(UIActionSheet *actionSheet, NSInteger index) {
//        
//        if (index == 0) {
//            // 相册
//            [self localPhoto];
//        }else if (index == 1) {
//            // 拍照
//            [self takePhoto];
//        }
//    }];
//    if (iOS8) {
//        [actionSheet showInView:self.window.viewController.view];
//
//    } else {
//        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
//    }
}

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


#pragma mark---------collectionViewDelegate----------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.orderCommentModel.isComment) {
        return self.modelImages.count;
        
    } else {
        return (self.selectImages.count == kMaxSelectImageCount) ? kMaxSelectImageCount : self.selectImages.count+1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HJIconImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJIconImageViewCell className] forIndexPath:indexPath];
    
    // 已经评价
    if (self.orderCommentModel.isComment) {
        cell.deleleButton.hidden = YES;
        if (self.modelImages.count) {
            NSString *imageString = self.modelImages[indexPath.row];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(imageString)] placeholderImage:kImageNamed(@"icon_shoplist_default")];
        }
        
    } else {
        
        if (indexPath.row == self.selectImages.count) {
            
            cell.iconImageView.image = [UIImage imageNamed:@"ic_b5_01"];
            cell.deleleButton.hidden = YES;
            
            [self addWarningText:cell];
        } else {
            
            cell.iconImageView.image = [self.selectImages objectAtIndex:indexPath.row];
            cell.deleleButton.hidden = NO;
            cell.deleleButton.tag = indexPath.row;
            [cell.deleleButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (self.selectImages.count == kMaxSelectImageCount) {
                [self.warnImageLabel removeFromSuperview];
            }
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(45, 45);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.orderCommentModel.isComment) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    } else {
        [self addimageAction];
    }
}

#pragma mark--------------textViewDelegate----------------------
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.warnLabel.hidden = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.contentTextView) {
        if (text.length == 0) return YES;
        
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 50) {
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.contentTextView.text.length ? (self.warnLabel.hidden = YES) : (self.warnLabel.hidden = NO);
}

#pragma  mark - Setter&Getter

- (NSMutableArray *)selectImages {
    
    if (!_selectImages) {
        
        _selectImages = [NSMutableArray array];
    }
    
    return _selectImages;
}

- (NSMutableArray *)modelImages
{
    if (!_modelImages) {
        _modelImages = [NSMutableArray array];
    }
    return _modelImages;
}
@end
