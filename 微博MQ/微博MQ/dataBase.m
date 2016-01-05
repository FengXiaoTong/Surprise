//
//  dataBase.m
//  微博MQ
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 com.qingyun. All rights reserved.
//

#import "dataBase.h"
#import "NSString+filePath.h"
#import "FMDB.h"
#import "Status.h"


#define kDBFileName @"status.db"//数据库的文件名字
#define kStatusTable @"status"//微博数据表的名字
static NSArray *statusTableColumn;//保存status表中的所有字段

@implementation dataBase

+(void)initialize
{
    if (self == [dataBase self]) {
        
        //将数据库文件copy到documents下
        [dataBase copyDatebaseFileToDocuments:kDBFileName];
        statusTableColumn = [dataBase tableColumn:kStatusTable];//初始化表的存放所含的字段数据
    }
}

+(void)copyDatebaseFileToDocuments:(NSString *)dbName
{
    NSString *source = [[NSBundle mainBundle]pathForResource:dbName ofType:nil];//源路径
    NSString *toPath = [NSString filePathInDocumentsWithFileName:dbName];
    NSError *error;
    if ([[NSFileManager defaultManager]fileExistsAtPath:toPath]) {
        //没有数据库文件才复制copy
        return;
    }
    
    [[NSFileManager defaultManager]copyItemAtPath:source toPath:toPath error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
}


+(NSArray *)tableColumn:(NSString *)tableName
{
      //创建db
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    [db open];
    
    //执行查询表结构的命令，返回结果（集合）
    FMResultSet *result = [db getTableSchema:tableName];
    NSMutableArray *columns = [NSMutableArray array];
    
    while ([result next]) {
        //name 字段对应了表的column的名字
        NSString *column = [result objectForColumnName:@"name"];
        [columns addObject:column];
    }
    [db close];
    
    return columns;
}


+(void)saveStatus:(NSArray *)statuses
{
    //插入操作，首先创建一个db对象，写sql语句 insert into 执行操作
    //创建一个DB
//    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    
    //db的创建交给queue处理
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        //数据库的增删改查工作，也可以分为两种工作，一个查询，一个更新
        [statuses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSDictionary *status = obj;
            
            //首先查找出所有的有效字段
            NSArray *allkey = status.allKeys;
            NSArray *contentkey = [dataBase contentKeyWith:statusTableColumn key2:allkey];
            
            //删除字典中多余的键值
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:status];
             //将微博字典status(不可变)转换为可变字典K
            [allkey enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //如果是多余的key,则删除
                if (![contentkey containsObject:obj]) {
                    [resultDic removeObjectForKey:obj];
                }
                
            }];
            
            
            //根据table和字典共有的key，创建插入语句
            NSString *sqlString = [dataBase sqlStringWithKeys:contentkey];
            //执行
           BOOL result = [db executeQuery:sqlString withParameterDictionary:resultDic];
            NSLog(@"%d",result);
            
        }];
    }];
    
}

//查询出两个数组中共有的方法
+(NSArray *)contentKeyWith:(NSArray *)key1 key2:(NSArray *)key2{
    
    NSMutableArray *result = [NSMutableArray array];
    [key1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *key = obj;
        //比较一个对象是否包含在另外的一个数组中
        if ([key2 containsObject:key]) {
            [result addObject:key];
       
        }
        
    }];
    return result;
}

+(NSString *)sqlStringWithKeys:(NSArray *)keys{
    //创建columns字段的sql语句部分
    NSString *columns = [keys componentsJoinedByString:@", "];
    //占位部分sql语句bufen
    NSString *values = [keys componentsJoinedByString:@", :"];
    values = [@":" stringByAppendingString:values];
    return [NSString stringWithFormat:@"insert into status (%@) values(%@)",columns, values];
    
}

+(NSArray *)getStatusFromDB{
    
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //打开数据库
    [db open];
    
    //查询语句
    NSString *sqlString = @"select * from status order by id desc limit 20";
    
    //执行查询并输出结果
    FMResultSet *result = [db executeQuery:sqlString];
    
    NSMutableArray *statusArray = [NSMutableArray array];
    while ([result next]) {
        //将一条记录转化为一个字典
        NSDictionary *dic = [result resultDictionary];
        
        NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];//将不可变字典转化为可变字典
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSData class]]) {
                id value = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
                [mudic setObject:value forKey:key];
                //排除掉空字符的情况
                if ([value isKindOfClass:[NSNull class]]) {
                    [mudic removeObjectForKey:key];
                }
            }
            
        }];
        Status *status = [[Status alloc]initStatusWithDictionary:mudic];//将字典转换为模型
        [statusArray addObject:status];
    }
    return statusArray;
}

@end
