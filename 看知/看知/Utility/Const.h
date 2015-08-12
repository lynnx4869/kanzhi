//
//  Const.h
//  看知
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#ifndef ___Const_h
#define ___Const_h

//主页List(GET)
#define lMainUrl @"http://api.kanzhihu.com/getposts/%@"  //%@距今秒数

/*类别：
archive:历史精华
recent:近期热门
yesterday:昨日最新*/

//详细List(GET)
#define lDetailUrl @"http://api.kanzhihu.com/getpostanswers/%@/%@" //日期+类别

//知乎界面(GET)
#define lZhihuUrl @"http://www.zhihu.com/question/%@#answer-%@" //questionId+answerId

//用户排行榜(GET)

//发表->
//提问
#define lAskUrl @"http://api.kanzhihu.com/topuser/ask/page/count"
//回答
//专栏

//赞同->
//赞同数
#define lAgreeUrl @"http://api.kanzhihu.com/topuser/agree/page/count"
//1日增加
#define lAgreeiUrl @"http://api.kanzhihu.com/topuser/agreei/page/count"
//1日增幅
#define lAgreeiratioUrl @"http://api.kanzhihu.com/topuser/agreeiratio/page/count"
//7日增加
#define lAgreeiwUrl @"http://api.kanzhihu.com/topuser/agreeiw/page/count"
//7日增幅
#define lAgreeiratiowUrl @"http://api.kanzhihu.com/topuser/agreeiratiow/page/count"
//平均赞同
#define lRatioUrl @"http://api.kanzhihu.com/topuser/ratio/page/count"

//关注->
//被关注数
//关注数
//1日增加
//1日增幅
//7日增加
//7日增幅

//感谢/收藏->
//感谢数
//感谢/赞同比
//收藏数
//收藏/赞同比
//公共编辑

//高票答案数量->
//>=10000
//>=5000
//>=2000
//>=1000
//>=500
//>=200
//>=100

//高票答案占比->
//最高赞同
//最高占比
//前五赞同
//前五占比
//前十赞同
//前十占比

//用户详情(GET)
#define lUserdetailUrl @"http://api.kanzhihu.com/userdetail2/%@" //hash值

//用户搜索(GET)
#define lSearchuserUrl @"http://api.kanzhihu.com/searchuser/%@" //用户名

//常见问题(GET)
#define lFaqUrl @"http://api.kanzhihu.com/faq"

#endif
