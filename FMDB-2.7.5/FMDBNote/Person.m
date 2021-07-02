//
//  Person.m
//  FMDBNote
//
//  Created by mayan on 2021/7/2.
//

#import "Person.h"

@implementation Person


- (instancetype)initWithId:(int)id name:(NSString *)name phone:(NSString *)phone
{
    self = [super init];
    if (self) {
        _id = id;
        _name = name;
        _phone = phone;
    }
    return self;
}


@end
