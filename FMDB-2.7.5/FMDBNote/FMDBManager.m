//
//  FMDBManager.m
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import "FMDBManager.h"
#import <FMDB.h>

@implementation FMDBManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static FMDBManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSTemporaryDirectory());
        
        [self.createQueue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL result = [db executeUpdate:@"create table if not exists t_person ('number' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' TEXT NOT NULL, 'phone' TEXT NOT NULL)"];
            if (result) {
                NSLog(@"%s 创建 table 成功", __func__);
            }
        }];
    }
    return self;
}

- (FMDatabaseQueue *)createQueue {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    return [FMDatabaseQueue databaseQueueWithPath:path];
}

- (void)getPersonArray:(void (^)(NSArray<Person *> * _Nonnull))block {
    [self.createQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSMutableArray *arr = [NSMutableArray array];
        
        FMResultSet *result = [db executeQuery:@"select * from 't_person'"];
        while (result.next) {
            Person *p = [[Person alloc] initWithId:[result intForColumn:@"number"]
                                              name:[result stringForColumn:@"name"]
                                             phone:[result stringForColumn:@"phone"]];
            [arr addObject:p];
        }
        NSLog(@"%s 获取到的 person 数量: %lu", __func__, (unsigned long)arr.count);
        block(arr);
    }];
}

- (void)addPerson:(Person *)person andProgressBlock:(void (^)(BOOL))block {
    [self.createQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"insert into 't_person'(number, name, phone) values(?, ?, ?)"
                   withArgumentsInArray:@[@(person.id), person.name, person.phone]];
        if (result) {
            NSLog(@"%s 添加 person 成功", __func__);
        }
        block(result);
    }];
}

@end
