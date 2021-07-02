//
//  FMDBManager.h
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

+ (instancetype)shareInstance;

- (void)getPersonArray:(void(^)(NSArray <Person *>*))block;
- (void)addPerson:(Person *)person andProgressBlock:(void(^)(BOOL))block;

@end

NS_ASSUME_NONNULL_END
