//
//  HJTabViewController.m
//  Cancer
//
//  Created by zhipeng-mac on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJTableViewController.h"

@implementation HJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //KVO
    [self addObserver:self forKeyPath:kDataSourceKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:kDataSourceKeyPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:kDataSourceKeyPath])
    {
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [self.selectItem addObject:@NO];
        }];
    }
}

#pragma mark - Public methods

- (void)showRightIndicatorWhenSelectedCell:(UITableViewCell *)cell indicatorSelectedImageName:(NSString *)selectedImageName cellIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *select = [self.selectItem objectAtIndex:indexPath.row];
    
    if (select.boolValue == YES) {
        
        UIImage *selectImage = kImageNamed(selectedImageName);
        UIImageView *selectImageView = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, selectImage.lh_sizeWidth, selectImage.lh_sizeHeight) image:selectImage];
        cell.accessoryView = selectImageView;
    } else {
        
        cell.accessoryView = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    NSNumber *selectIndex = self.selectItem[indexPath.row];
//    [self.selectItem replaceObjectAtIndex:indexPath.row withObject:@(!selectIndex.boolValue)];
//    [self.tableView reloadData];
//}

#pragma  mark - Setter&Getter

- (NSMutableArray *)selectItem {
    
    if (!_selectItem) {
        
        _selectItem = [NSMutableArray array];
    }
    
    return _selectItem;
}

@end
