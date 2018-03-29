//
//  JDTabBarController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/12.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "HJTabBarController.h"
#import "HJNavigationController.h"
#import "HJStoryBoardItem.h"

@interface HJTabBarController () <UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *tabBarItemTitles;
@property (nonatomic,strong) NSArray *tabBarItemNormalImages;
@property (nonatomic,strong) NSArray *tabBarItemSelectedImages;
@property (nonatomic,strong) NSArray *tabBarStoryBoardItems;

@end

@implementation HJTabBarController

#pragma mark - LifeCycle

+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kFontGrayColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APP_COMMON_COLOR, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //
    self.tabBar.translucent = NO;

    //添加所有的自控制器
    [self addAllChildVcs];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Methods

- (void)addAllChildVcs {
    
    for (int i=0; i < self.tabBarStoryBoardItems.count; i++) {
        
        HJStoryBoardItem *storyBoardItem = self.tabBarStoryBoardItems[i];
        UIViewController *childVC = [storyBoardItem correspondingViewController];
        //
        [self addOneChildVc:childVC title:self.tabBarItemTitles[i] imageName:self.tabBarItemNormalImages[i] selectedImageName:self.tabBarItemSelectedImages[i] tabBarItemIndex:i];
    }
}

- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tabBarItemIndex:(NSUInteger)tabBarItemIndex {
    
    //设置标题
    childVc.title = title;
    //设置图标
    [childVc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //设置选中图标
    [childVc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    //设置背景
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    
    HJNavigationController *nav = [[HJNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

#pragma mark - Setter&Getter

- (NSArray *)tabBarItemTitles {
    
    if (!_tabBarItemTitles) {
        
        _tabBarItemTitles = @[ @"首页",
                               @"分类",
                               @"购物车",
                               @"我的"];
    }
    
    return _tabBarItemTitles;
}

- (NSArray *)tabBarItemNormalImages {
    
    if (!_tabBarItemNormalImages) {
        
        _tabBarItemNormalImages =@[ @"ic_tab_01",
                                    @"ic_tab_02",
                                    @"ic_tab_03",
                                    @"ic_tab_04"];
    }
    
    return _tabBarItemNormalImages;
}

- (NSArray *)tabBarItemSelectedImages {
    
    if (!_tabBarItemSelectedImages) {
        
        _tabBarItemSelectedImages = @[ @"ic_tab_01_pre",
                                       @"ic_tab_02_pre",
                                       @"ic_tab_03_pre",
                                       @"ic_tab_04"];
    }
    
    return _tabBarItemSelectedImages;
}

- (NSArray *)tabBarStoryBoardItems {
    
    if (!_tabBarStoryBoardItems) {
        
        
        HJStoryBoardItem *item1 = [HJStoryBoardItem itemWithStroyBoardName:SB_HOME_PAGE identifier:@"HJHomePageTVC" viewControllerExist:NO];
        HJStoryBoardItem *item2 = [HJStoryBoardItem itemWithStroyBoardName:SB_Classify identifier:@"HJClassifyVC" viewControllerExist:NO];
        HJStoryBoardItem *item3 = [HJStoryBoardItem itemWithStroyBoardName:SB_SHOPPING_CART identifier:@"HJShoppingCartTVC" viewControllerExist:NO];
        HJStoryBoardItem *item4 = [HJStoryBoardItem itemWithStroyBoardName:SB_SHOPPING_CART identifier:@"HJPersonCenterTVC" viewControllerExist:NO];

        _tabBarStoryBoardItems = @[ item1,
                                    item2,
                                    item3,
                                    item4
                                    ];
    }
    
    return _tabBarStoryBoardItems;
}

@end
