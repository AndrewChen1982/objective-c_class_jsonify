//
//  JSON_Serializer.h
//  JSON_Serializer
//
//  Created by Andrew Chen on 2018/11/13.
//  Copyright © 2018年 Andrew Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSON_DataBlockProtocol
- (NSString *const)serialize:(Class<JSON_DataBlockProtocol>)metaClass;
- (id<JSON_DataBlockProtocol>)deserialize:(NSString *)jsonStr;
@end

@interface JSON_DataBlock : NSObject<JSON_DataBlockProtocol>
{
@protected
    NSMutableDictionary *ignoreSerializeTab;
    NSMutableDictionary *ignoreDeserializeTab;
    NSMutableDictionary *iVarCollection;
}

- (JSON_DataBlock *)addIgnoreSerializeVar:(NSString *)iVarName;
- (JSON_DataBlock *)addIgnoreDeserializeVar:(NSString *)iVarName;
@end



