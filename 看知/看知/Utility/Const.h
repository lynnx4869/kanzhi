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

//用户排行榜(GET) (页数/数量 page/count)

//发表->
//提问
#define lAskUrl @"http://api.kanzhihu.com/topuser/ask/%@/%@"
//回答
#define lAnswerUrl @"http://api.kanzhihu.com/topuser/answer/%@/%@"
//专栏
#define lPostUrl @"http://api.kanzhihu.com/topuser/post/%@/%@"

//赞同->
//赞同数
#define lAgreeUrl @"http://api.kanzhihu.com/topuser/agree/%@/%@"
//1日增加
#define lAgreeiUrl @"http://api.kanzhihu.com/topuser/agreei/%@/%@"
//1日增幅
#define lAgreeiratioUrl @"http://api.kanzhihu.com/topuser/agreeiratio/%@/%@"
//7日增加
#define lAgreeiwUrl @"http://api.kanzhihu.com/topuser/agreeiw/%@/%@"
//7日增幅
#define lAgreeiratiowUrl @"http://api.kanzhihu.com/topuser/agreeiratiow/%@/%@"
//平均赞同
#define lRatioUrl @"http://api.kanzhihu.com/topuser/ratio/%@/%@"

//关注->
//被关注数
#define lFollowerUrl @"http://api.kanzhihu.com/topuser/follower/%@/%@"
//关注数
#define lFolloweeUrl @"http://api.kanzhihu.com/topuser/followee/%@/%@"
//1日增加
#define lFolloweriUrl @"http://api.kanzhihu.com/topuser/followeri/%@/%@"
//1日增幅
#define lFolloweriUrl @"http://api.kanzhihu.com/topuser/followeri/%@/%@"
//7日增加
#define lFolloweriwUrl @"http://api.kanzhihu.com/topuser/followeriw/%@/%@"
//7日增幅
#define lFolloweriwUrl @"http://api.kanzhihu.com/topuser/followeriw/%@/%@"

//感谢/收藏->
//感谢数
#define lThanksUrl @"http://api.kanzhihu.com/topuser/thanks/%@/%@"
//感谢/赞同比
#define lTratioUrl @"http://api.kanzhihu.com/topuser/thanks/%@/%@"
//收藏数
#define lFavUrl @"http://api.kanzhihu.com/topuser/fav/%@/%@"
//收藏/赞同比
#define lFratioUrl @"http://api.kanzhihu.com/topuser/fratio/%@/%@"
//公共编辑
#define lLogsUrl @"http://api.kanzhihu.com/topuser/logs/%@/%@"

//高票答案数量->
//>=10000
#define lCount10000Url @"http://api.kanzhihu.com/topuser/count10000/%@/%@"
//>=5000
#define lCount5000Url @"http://api.kanzhihu.com/topuser/count5000/%@/%@"
//>=2000
#define lCount2000Url @"http://api.kanzhihu.com/topuser/count2000/%@/%@"
//>=1000
#define lCount1000Url @"http://api.kanzhihu.com/topuser/count1000/%@/%@"
//>=500
#define lCount500Url @"http://api.kanzhihu.com/topuser/count500/%@/%@"
//>=200
#define lCount200Url @"http://api.kanzhihu.com/topuser/count200/%@/%@"
//>=100
#define lCount100Url @"http://api.kanzhihu.com/topuser/count100/%@/%@"

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
