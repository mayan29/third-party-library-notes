//
//  FMDBManager.m
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import "FMDBManager.h"
#import <FMDB.h>

@interface FMDBManager ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

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
        
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
        self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
        
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL result = [db executeUpdate:@"create table if not exists t_person ('number' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' TEXT NOT NULL, 'phone' TEXT NOT NULL)"];
            if (result) {
                NSLog(@"%s 创建 table 成功", __func__);
            }
        }];
    }
    return self;
}

- (void)getPersonArray:(personArrayBlock)block
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSArray *arr = [self __getPersonArrayWithDataBase:db];
        block(arr);
    }];
}

- (void)addPerson:(Person *)person andProgressBlock:(personArrayBlock)block
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"insert into 't_person'(number, name, phone) values(?, ?, ?)"
                   withArgumentsInArray:@[@(person.id), person.name, person.phone]];
        if (result) {
            NSLog(@"%s 添加 person 成功", __func__);
            NSArray *arr = [self __getPersonArrayWithDataBase:db];
            block(arr);
        }
    }];
}

- (NSArray <Person *>*)__getPersonArrayWithDataBase:(FMDatabase *)db {
    FMResultSet *result = [db executeQuery:@"select * from 't_person'"];
    
    NSMutableArray *arr = [NSMutableArray array];
    while (result.next) {
        Person *p = [[Person alloc] initWithId:[result intForColumn:@"number"]
                                          name:[result stringForColumn:@"name"]
                                         phone:[result stringForColumn:@"phone"]];
        [arr addObject:p];
    }
    NSLog(@"%s 获取到的 person array: %@", __func__, arr);
    
    return arr.copy;
}


@end
