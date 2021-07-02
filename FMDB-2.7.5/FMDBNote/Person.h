//
//  Person.h
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, assign, readonly) int id;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *phone;

- (instancetype)initWithId:(int)id name:(NSString *)name phone:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
