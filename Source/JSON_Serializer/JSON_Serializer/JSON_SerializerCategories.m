//
//  NSDictionary+JSON.m
//  CE_SDK_Framework
//
//  Created by Andrew Chen on 2018/4/19.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import "JSON_SerializerCategories.h"

@implementation NSString (JSON)

- (NSDictionary *) toJsonObject {
    NSError *err;
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&err];
    
    return jsonObj;
}
@end


@implementation NSDictionary (JSON)

- (NSString *)toJSONString:(NSJSONWritingOptions)options {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:options
                                                         error:&error];
    NSString *jsonString = nil;
    
    if (jsonData == nil) {
        NSAssert1(false ,@"NSDictionary:toJSONString:options got errors: %@", [error localizedDescription] );
    }
    else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
