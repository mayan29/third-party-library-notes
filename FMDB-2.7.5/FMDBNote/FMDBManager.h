//
//  FMDBManager.h
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^personArrayBlock)(NSArray <Person *>*);

@interface FMDBManager : NSObject

+ (instancetype)shareInstance;

- (void)getPersonArray:(personArrayBlock)block;
- (void)addPerson:(Person *)person andProgressBlock:(personArrayBlock)block;

@end

NS_ASSUME_NONNULL_END
