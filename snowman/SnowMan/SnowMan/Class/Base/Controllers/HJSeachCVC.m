//
//  HJSeachCVC.m
//  Cancer
//
//  Created by IMAC on 16/2/15.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJSeachCVC.h"
#import "HJsearchCell.h"
#import "HJHeaderView.h"

#define KMargin 10
#define KcellWidth (SCREEN_WIDTH - 20*2-2*KMargin)/3
#define KcellHeight 40

@interface HJSeachCVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIButton *commitBtn;
}
@end

@implementation HJSeachCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"搜索结果";
    //确认
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [searchBtn addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [searchBtn setTitleColor:APP_COMMON_COLOR forState:UIControlStateNormal];
    searchBtn.titleLabel.font = FONT(14);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = item;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HJsearchCell" bundle:nil] forCellWithReuseIdentifier:@"HJsearchCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HJHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HJHeaderView"];
    commitBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50) target:self action:@selector(commitClick) backgroundColor:APP_COMMON_COLOR];
    [commitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [commitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    commitBtn.titleLabel.font = FONT(15);
    [self.view addSubview:commitBtn];
}
- (void)searchClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.HJSearchType = HJSearchTypePressDown;
    }else
    {
        self.HJSearchType = HJSearchTypePressUp;
    }
}
- (void)commitClick
{


}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    switch (self.HJSearchType) {
        case HJSearchTypePressDown:
            return 3;
            break;
        case HJSearchTypePressUp:
            return 1;
            break;
        default:
            break;
    }

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.HJSearchType) {
        case HJSearchTypePressDown:
            switch (section) {
                case 0:
                    return 2;
                    break;
                case 1:
                    return 10;
                    break;
                case 2:
                    return 12;
                    break;
                default:
                    break;
            }            break;
        case HJSearchTypePressUp:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJsearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJsearchCell" forIndexPath:indexPath];
    [cell lh_setCornerRadius:3 borderWidth:1 borderColor:kLightGrayColor];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HJHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HJHeaderView" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            headerView.groupName.text = @"用户类型：";
            break;
        case 1:
            headerView.groupName.text = @"治疗状态：";
            break;
        case 2:
            headerView.groupName.text = @"所患疾病：";
            break;
        default:
            break;
    }
    
    return headerView;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 20, 8, 20);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KcellWidth, KcellHeight);

}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
