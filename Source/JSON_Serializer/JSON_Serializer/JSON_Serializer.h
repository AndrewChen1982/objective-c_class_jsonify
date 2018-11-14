//
//  DataPackage.h
//  CE_SDK_Framework
//
//  Created by Andrew Chen on 2018/4/20.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON_SerializerDataBlock.h"

@interface JSON_Serializer<__covariant SerializableDB:NSObject<JSON_DataBlockProtocol> *> : JSON_DataBlock
{
@public
    NSString *request;
    int code;
    
@protected
//    SerializableDB content;
    JSON_DataBlock *content;
}

- (instancetype)initWithDataBlock:(Class<JSON_DataBlockProtocol>)datablock;

//- (SerializableDB)getDataBlock;
- (JSON_DataBlock *)getDataBlock;
- (NSString *)toJsonString;


@end
