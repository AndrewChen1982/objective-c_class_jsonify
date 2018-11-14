//
//  JSON_SerializerUtility.h
//  JSON_Serializer
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#ifndef JSON_SerializerUtility_h
#define JSON_SerializerUtility_h

#define GetiVarName(arg) ({ \
NSString *argStr = @#arg; \
argStr = [argStr stringByReplacingOccurrencesOfString:@"self->" withString:@""]; \
argStr = [argStr stringByReplacingOccurrencesOfString:@"self." withString:@""]; \
argStr; \
})

#endif /* JSON_SerializerUtility_h */
