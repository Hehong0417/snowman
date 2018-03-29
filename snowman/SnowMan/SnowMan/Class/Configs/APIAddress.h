//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//

/**
 *   一、接口基础模块
 */

#ifdef DEBUG

//// 服务器地址
//#define API_HOST @"http://192.168.0.89:8080"
////图片地址
//#define API_IMAGE_HOST @"http://192.168.0.11:7080/"

// 服务器地址
#define API_HOST @"http://120.24.182.187:8090"
//图片地址
#define API_IMAGE_HOST @"http://120.24.182.187:7080/"

#else

// 服务器地址
#define API_HOST @"http://120.24.182.187:8090"
//图片地址
#define API_IMAGE_HOST @"http://120.24.182.187:7080/"

#endif

#define APP_key @"59334e721bcd31"

//MD5加密（APP_key+””）
#define APP_scode @"0b9aa15373515ee38120d7caf42a6946"

#define API_APP_BASE_URL @"snowman"

#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]
#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

// 接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

// 图片
//#define kAPIImageFromUrl(url) [[NSString stringWithFormat:@"%@%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define kAPIImageFromUrl(url) ([url rangeOfString:@"http"].location != NSNotFound) ? [(url) stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] : [[NSString stringWithFormat:@"%@%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

/**
 *  二、登录注册
 */

//2.1请求发送验证码
#define API_GET_CAPTCHA API_SUB_URL(@"phone/getCaptcha.do")

//2.2注册
#define API_REGISTER API_SUB_URL(@"phone/register.do")

//2.3登录
#define API_LOGIN API_SUB_URL(@"phone/login.do")

//2.4找回密码
#define API_GET_BACK_PWD API_SUB_URL(@"phone/getBackPwd.do") //*

//2.5手机唯一性验证
#define API_CHECK_PHONE API_SUB_URL(@"phone/checkPhone.do")

/**
 *  三、首页
 */

//3.1首页广告图列表
#define API_BANNER_LIST API_SUB_URL(@"home/bannerList.do")

//3.2首页每周特卖列表
#define API_WEEKLY_SALE_LIST API_SUB_URL(@"home/weeklysaleList.do")

//3.3首页今日上新列表
#define API_NEW_LIST API_SUB_URL(@"home/newList.do")

//3.4进入签到页面
#define API_GET_CHECKIN API_SUB_URL(@"home/getCheckin.do")

//3.5签到
#define API_CHECKIN API_SUB_URL(@"home/checkin.do")

//3.5签到
#define API_CHECKIN API_SUB_URL(@"home/checkin.do")

//3.5签到
#define API_CHECKIN API_SUB_URL(@"home/checkin.do")

//3.6许愿
#define API_WISH API_SUB_URL(@"home/wish.do")

//3.7热门搜索列表
#define API_HOT_SEARCH API_SUB_URL(@"home/hotSearch.do")

//3.8搜索
#define API_SEARCH API_SUB_URL(@"home/search.do")

//3.9商品介绍
#define API_GOODS_INTRODUCE API_SUB_URL(@"home/goodsIntroduce.do")

//3.10商品详情
#define API_GOODS_DETAILS API_SUB_URL(@"home/goodsDetails.do")

//3.11商品评论
#define API_GOODS_COMMENT API_SUB_URL(@"home/goodsComment.do")

//3.12结算页面
#define API_SETTLEMENT   API_SUB_URL(@"home/settlement.do")

//3.13送货时间列表
#define API_DELIVER_TIME   API_SUB_URL(@"home/deliverTime.do")

//3.14收货地址管理
#define API_RECEIPT_ADDRESS   API_SUB_URL(@"home/receiptAddress.do")

//3.15编辑、新增收货地址
#define API_EDIT_ADRESS   API_SUB_URL(@"home/editAddress.do")
//3.16所在地区列表
#define API_AREALIST   API_SUB_URL(@"home/areaList.do")
//3.17设置默认地址
#define API_DEFAULT_ADDRESS   API_SUB_URL(@"home/defaultAddress.do")
//3.18删除地址
#define API_DELETE_ADDRESS   API_SUB_URL(@"home/deleteAddress.do")
//3.20直接购买提交订单
#define API_SUBMIT_ORDER   API_SUB_URL(@"home/submitOrder.do")
//
#define API_CART_SUBMIT_ORDER   API_SUB_URL(@"home/cartSubmitOrder.do")

//四、分类

//4.1一级分类列表
#define API_FIRST_CLASSIFY   API_SUB_URL(@"classify/firstClassify.do")
//4.2二级分类列表
#define API_SECONDC_CLASSIFY   API_SUB_URL(@"classify/secondClassify.do")
//4.3获取品牌列表
#define API_BRAND API_SUB_URL(@"classify/brand.do")
//4.4根据分类条件获取商品列表
#define API_GET_GOODS_LIST API_SUB_URL(@"classify/getGoodsList.do")


/**
 *  五、购物车
 */

//5.1购物车
#define API_SHOPCART_BRAND API_SUB_URL(@"shopCart/brand.do") //*

//5.2编辑删除购物车
#define API_EDIT_BRAND  API_SUB_URL(@"shopCart/editBrand.do")
//5.3加入购物车
#define API_JOINSHOPCART API_SUB_URL(@"shopCart/joinShopCart.do")
//5.4加入货箱
#define API_JOINBOX API_SUB_URL(@"shopCart/joinBox.do")


/**
 *  六、我的
 */

//6.1我的资料首页
#define API_GET_USER_INFO API_SUB_URL(@"userElse/getUserInfo.do")
//6.2修改用户头像
#define API_USERICO API_SUB_URL(@"userElse/userIco.do")
//6.3修改用户昵称
#define API_UPDATEUSERNAME API_SUB_URL(@"userElse/updateUserName.do")
//6.4修改用户密码
#define API_UPDATEPWD API_SUB_URL(@"userElse/updatePwd.do")
//6.5我的积分
#define API_SCORE API_SUB_URL(@"userElse/score.do")
//6.6我的订单列表
#define API_ORDERLIST API_SUB_URL(@"userElse/orderList.do")
//6.7我的订单详情
#define API_ORDERINFO API_SUB_URL(@"userElse/orderInfo.do")
//6.8取消订单
#define API_DELETE_ORDER API_SUB_URL(@"userElse/cancelOrder.do")
//6.9确认订单
#define API_CONFIRMINDENT API_SUB_URL(@"userElse/confirmOrder.do")
//6.10删除订单
#define API_DELETEORDER API_SUB_URL(@"userElse/deleteOrder.do")
//6.11申请售后页面
#define API_CUSTOMER_SERVICE API_SUB_URL(@"userElse/customerService.do")
//6.12申请售后
#define API_APPLICATION_SALES API_SUB_URL(@"userElse/applicationSales.do")
//6.13评论页面
#define API_COMMENTPAG API_SUB_URL(@"userElse/commentPag.do")
//6.14评论
#define API_COMMENT API_SUB_URL(@"userElse/comment.do")
//6.15退换货列表
#define API_AFTER_SALES_LIST API_SUB_URL(@"userElse/afterSalesList.do")
//6.16退换货详情
#define API_AFTER_SALES_INFO API_SUB_URL(@"userElse/afterSalesInfo.do")
//6.17删除退换货订单
#define API_DELETE_REFUND API_SUB_URL(@"userElse/deleteRefund.do")
//6.18积分规则
#define API_INTEGRAL_RULE API_SUB_URL(@"userElse/integralRule.do")
//6.19常见问题
#define API_COMMON_PROBLEM API_SUB_URL(@"userElse/commonProblem.do")


/**
 * 七、 支付
 */

//7.1支付订单
#define API_GETPAYCHARGE API_SUB_URL(@"pay/getPayCharge.do")



