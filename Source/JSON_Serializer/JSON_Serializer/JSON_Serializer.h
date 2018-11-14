//
//  DataPackage.h
//  CE_SDK_Framework
//
//  Created by Andrew Chen on 2018/4/20.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSON_DataBlockProtocol
@end

@interface JSON_SerializerHandler : NSObject
{
@protected
    NSMutableDictionary *ignoreSerializeTab;
    NSMutableDictionary *ignoreDeserializeTab;
    NSMutableDictionary *iVarCollection;
}

- (NSString *const)serialize:(id<JSON_DataBlockProtocol>)datablock
                   metaClass:(Class<JSON_DataBlockProtocol>)metaClass;
- (id<JSON_DataBlockProtocol>)deserialize:(id<JSON_DataBlockProtocol>)datablock
                                metaClass:(Class<JSON_DataBlockProtocol>)metaClass
                                  jsonStr:(NSString *)jsonStr;

- (JSON_SerializerHandler *)addIgnoreSerializeVar:(NSString *)iVarName;
- (JSON_SerializerHandler *)addIgnoreDeserializeVar:(NSString *)iVarName;
@end


@interface JSON_Serializer<__covariant SerializableDB:NSObject<JSON_DataBlockProtocol> *> : JSON_SerializerHandler
{
    
@protected
    NSString *jsonString;
    SerializableDB content;
}

- (instancetype)initWithDataBlock:(Class<JSON_DataBlockProtocol>)datablock;

- (SerializableDB)getDataBlock;
- (NSString *)toJsonString;
- (id<JSON_DataBlockProtocol>)toClassObject:(NSString*)jsonStr;


@end
