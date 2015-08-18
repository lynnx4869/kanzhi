//
//  DBManager.m
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@interface DBManager ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation DBManager

+ (DBManager *)shareManager{
    static DBManager *manager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        if(manager == nil){
            manager = [[DBManager alloc] init];
        }
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDataBase];
    }
    return self;
}

- (void)createDataBase{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/app.sqlite"];
    _dataBase = [[FMDatabase alloc] initWithPath:path];
    
    BOOL ret = [_dataBase open];
    if(!ret){
        NSLog(@"数据库打开失败:%@", [_dataBase lastError]);
    }else{
        NSString *createCollectsSql = @"create table if not exists collects(id integer primary key autoincrement, title varchar(225), questionid varchar(255), answerid varchar(255), authorname varchar(255))";
        BOOL collectsFlag = [_dataBase executeUpdate:createCollectsSql];
        if(!collectsFlag){
            NSLog(@"创建表格失败:%@", [_dataBase lastError]);
        }

//        NSString *createFollowsSql = @"create table if not exists follows(id integer primary key autoincrement, applicationId varchar(20), name varchar(255), image blob)";
//        BOOL followsFlag = [_dataBase executeUpdate:createFollowsSql];
//        if(!followsFlag){
//            NSLog(@"创建表格失败:%@", [_dataBase lastError]);
//        }
    }
}

- (BOOL)isHadCollected:(PostDetailModel *)model{
    NSString *sql = @"select * from collects where questionid = ? and answerid = ?";
    FMResultSet *result = [_dataBase executeQuery:sql, model.questionid, model.answerid];
    if([result next]){
        return YES;
    }else{
        return NO;
    }
}

- (void)collectPost:(PostDetailModel *)model{
    NSString *sql = @"insert into collects(title, questionid, answerid, authorname) values(?, ?, ?, ?)";
    BOOL ret = [_dataBase executeUpdate:sql, model.title, model.questionid, model.answerid, model.authorname];
    if(!ret){
        NSLog(@"插入收藏失败:%@", [_dataBase lastError]);
    }
}

- (NSArray *)queryAllCollects{
    NSString *sql = @"select * from collects";
    FMResultSet *result = [_dataBase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while([result next]){
        PostDetailModel *model = [[PostDetailModel alloc] init];
        model.title = [result stringForColumn:@"title"];
        model.questionid = [result stringForColumn:@"questionid"];
        model.answerid = [result stringForColumn:@"answerid"];
        model.authorname = [result stringForColumn:@"authorname"];
        [array addObject:model];
    }
    return array;
}

- (void)deleteCollect:(PostDetailModel *)model{
    NSString *sql = @"delete from collects where questionid = ? and answerid = ?";
    BOOL ret = [_dataBase executeUpdate:sql, model.questionid, model.answerid];
    if(!ret){
        NSLog(@"删除收藏失败:%@", [_dataBase lastError]);
    }
}

@end
