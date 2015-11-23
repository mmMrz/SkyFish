//
//  Http.h
//  CQSQ
//
//  Created by linan on 15-2-4.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#ifndef CQSQ_Http_h
#define CQSQ_Http_h

#define PUBLIC_CONFIGS @"public/configs"//app初始化

#define SERVER_URL @"http://120.27.55.225/"//服务器地址
//用户
#define USER_LOGIN @"/user/login/"//用户登录
#define USER_UPDATEADDR @"/user/updateAddr" //位置更新
#define USER_GETMYINFO @"/user/getmyinfo" //获取本人信息
#define USER_GETUSERINFO @"/user/getUserinfo" //获取用户信息

//钓点
#define PLACE_GETPLACE @"/place/getPlace"//获取钓点列表
#define PLACE_GETITEM @"/place/getItem"//获取钓点详情
#define PLACE_SCORELIST @"/place/scoreList"//获取评分列表
#define PLACE_SCOREDETAIL @"/place/scoreDetail"//获取评分详情
#define PLACE_SCORE @"/place/score"//发布评分

//微博
#define WEIBO_ADD @"weibo/add/"//写微博
#define WEIBO_GETLISTGROUND @"/weibo/getListGround/"//取微博列表_广场
#define WEIBO_GETLISTNEAR @"/weibo/getListNear/"//取微博列表_附近
#define WEIBO_GETLISTFRIEND @"/weibo/getListFriend/"//取微博列表_朋友
#define WEIBO_GETITEM @"/weibo/getItem/"//取微博_详情
#define WEIBO_GETLIST @"/weibo/getList/"//取微博列表_某用户

//通用
#define COMMON_QINIUTOKEN @"/common/qiniuToken"//获取七牛token
#define QINIU_IMGURL @"http://7xn7nj.com2.z0.glb.qiniucdn.com/"//七牛图片地址拼接前缀

#endif
