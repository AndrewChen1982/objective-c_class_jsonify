//
//  NSDictionary+JSON.h
//  CE_SDK_Framework
//
//  Created by Andrew Chen on 2018/4/19.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
- (NSDictionary *)toJsonObject;
@end


@interface NSDictionary (JSON)
- (NSString *)toJSONString:(NSJSONWritingOptions) options;
@end
