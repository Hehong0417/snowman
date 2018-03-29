
//导航栏标题字体大小
#define AppNavigationFont [UIFont systemFontOfSize:17]
#define FontBigSize [UIFont systemFontOfSize:16]
#define FontNormalSize [UIFont systemFontOfSize:14]
#define FontSmallSize [UIFont systemFontOfSize:12]

//公用颜色
#define APP_COMMON_COLOR RGB(228, 60, 58)
#define kVCBackGroundColor RGB(240, 240, 240)
#define kLineLightColor RGB(229, 229, 229)
#define kLineDeepColor RGB(204, 204, 204)
#define kFontLightGrayColor RGB(153, 153, 153)
#define kFontGrayColor RGB(102, 102, 102)
#define kFontBlackColor RGB(51, 51, 51)
#define KButtonColor RGB(244, 139, 62)

// 两位小数浮点型
#define KIntToFloat(x) (x)/1.0

#define KAnimationTime 0.25

//圆角大小
#define kSmallCornerRadius 3.0f
//用户信息
#define USER_ID_KEY @"userId"
#define USER_TOKEN_KEY @"token"
#define USER_ID     ([uDefault objectForKey:@"userId"]?[uDefault objectForKey:@"userId"]:@"")
#define USER_TOKEN  ([uDefault objectForKey:@"token"]?[uDefault objectForKey:@"token"]:@"")
#define USER_CURRENT_ADDRESS @"user_current_address"
#define uDefault_CURRENT_ADDRESS [uDefault objectForKey:USER_CURRENT_ADDRESS]

//storyboard
#define SB_HOME_PAGE @"HomePage"
#define SB_Classify @"IncrementService"
#define SB_PERSON_CENTER @"PersonCenter"
#define SB_SHOPPING_CART @"ShoppingCart"
#define SB_LOGIN @"Login"

//键盘高度
#define kKeyBoardNormalHeight 216.0f

//输入文字限制
static const NSUInteger kReasonNoteMaxLength = 300;

//边框间距
static const CGFloat kGroupTablePadding = 15;
static const CGFloat kNormalButtonMargin = 30;
#define kNormalButtonWidth (SCREEN_WIDTH-kNormalButtonMargin*2)
#define kNormalButtonHeight 35

//NOTIFICATION
//登录失效通知
#define kNotifation_TokenInvalidate @"kNotifation_TokenInvalidate"
//选择改变首页定位城市通知
#define kNotification_ChangeLocationCity @"kNotification_ChangeLocationCity"
//改变收货地区选择的通知
#define kNotification_ChangeRecieveGoodsAearCity @"kNotification_ChangeRecieveGoodsAearCity"
//改变收货地区选择的通知
#define kNotification_ChangeMyOrderListSelectedOrderState @"kNotification_ChangeMyOrderListSelectedOrderState"

// 定位本地保存文件
#define kAmapLocationFile  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"kAmapLocationFile"]

#define kUrlScheme      @"hjSnowManPay" // 这个是你定义的 URL Scheme，支付宝、微信支付和测试模式需要。

typedef NS_ENUM(NSUInteger, HJOrderState) {
    HJOrderStateWaitPaid = 1,
    HJOrderStateWaitRecieveGoods,
    HJOrderStateSureRecieveGoods,
    HJOrderStateFinished,
    HJOrderStateReturnOfGoods,
    HJOrderStateDeleteAfter,
};

//规格值类型(0:箱、1:袋、2:斤)
typedef NS_ENUM(NSUInteger, HJStandardValueType) {
    HJStandardValueTypeBox = 0,
    HJStandardValueTypeBag,
    HJStandardValueTypeKG,
};

//支付类型
typedef NS_ENUM(NSUInteger, HJPayChannelType) {
    HJPayChannelTypeAliPay = 1,
    HJPayChannelTypeWx,
    HJPayChannelTypeOffLine,
};


// 收货地址管理类型(0:添加、1:修改)
typedef NS_ENUM(NSUInteger, HJAddressManagerType) {
    HJAddressManagerTypeAdd = 0,
    HJAddressManagerTypeEdit,
};

// 售后类型(0:换货、1:退货)
typedef NS_ENUM(NSUInteger, HJSaleType) {
    HJSaleTypeExchangeGoods = 1,
    HJSaleTypeReturnGoods,
};

// 跳转结果类型
typedef NS_ENUM(NSUInteger, HJResultType) {
    HJResultTypeSale = 1,
    HJResultTypePurchase,
    HJResultTypeWish,
    HJResultTypeDelete,
    HJResultTypeCertain,
    HJResultTypePaySuccess,
};

//公用Block
typedef void(^voidBlock)();
typedef void(^idBlock)(id obj);
typedef void(^stringBlock)(NSString *result);
typedef void(^stringBlock2)(NSString *result,NSString *description);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^intergerBlock)(NSInteger index);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayAndDescription)(NSArray *results,NSString *description);
typedef void(^arrayBlock)(NSArray *results);
typedef void(^successBlock)(id resultObj);
