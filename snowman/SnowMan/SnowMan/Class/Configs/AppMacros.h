// -------------------- Common Function --------------------------
#pragma mark - Common Function
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb converter（hex->dec）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FONT(x) [UIFont systemFontOfSize:x]

//AppDelegate
#define GGAppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

//NSString
#define STRING_OR_EMPTY(A)  ({ __typeof__(A) __a = (A); __a ? __a : @""; })
#define STRING_WITH_INTEGER(value) ([NSString stringWithFormat:@"%ld",value])
#define STRING_WITH_FLOAT(value) ([NSString stringWithFormat:@"%lf",value])
#define EMPTY_STRING @""
//NSLocalizedString
#define LS(string) NSLocalizedString(string,nil)

//NSUserDefault
#define uDefault [NSUserDefaults standardUserDefaults]

//[NSFileManager defaultManager]
#define FileManager [NSFileManager defaultManager]

//ReachNetWork
#define isInWifi [[Reachability reachabilityForInternetConnection] isReachableViaWiFi]
#define isOnline [[Reachability reachabilityForInternetConnection] isReachable]

//documents structure of application
#define APP_DOCUMENT                [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_LIBRARY                 [NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark - Device Information

#define is4Inches ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina [UIScreen mainScreen].scale > 1
#define DeviceIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define NavigationBar_HEIGHT 44
#define TABBAR_HEIGHT 49
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WidthScaleSize(x) ((x/320.0)*MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define nav_item_space -5
//#define WidthScaleSize(y) (y/568.0)*Screen_Height

#pragma mark - System Information

#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define isIOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")


//UI heights
#define STATUSBAR_HEIGHT 20.0
#define NAVBAR_HEIGHT 44.0
#define STATUS_NAV_HEIGHT 64.0

//NSString
#define kEmptySrting @""

// -------------------- Debug Function --------------------------
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [File %s: Line %d] " fmt), __PRETTY_FUNCTION__, __FILE__, __LINE__, ##__VA_ARGS__)
#   define DLogRect(rect)  DLog(@"%@", NSStringFromCGRect(rect))
#   define DLogPoint(pt) DLog(@"%@", NSStringFromCGPoint(pt))
#   define DLogSize(size) DLog(@"%@", NSStringFromCGSize(size))
#   define DLogColor(_COLOR) DLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)
#   define DLogSuperViews(_VIEW) { for (UIView* view = _VIEW; view; view = view.superview) { GBLog(@"%@", view); } }
#   define DLogSubViews(_VIEW) \
{ for (UIView* view in [_VIEW subviews]) { GBLog(@"%@", view); } }
#   else
#   define DLog(...)
#   define DLogRect(rect)
#   define DLogPoint(pt)
#   define DLogSize(size)
#   define DLogColor(_COLOR)
#   define DLogSuperViews(_VIEW)
#   define DLogSubViews(_VIEW)
#   endif

//weakself
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#define _LolitaFunctions [LolitaFunctions sharedObject]
//颜色
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
