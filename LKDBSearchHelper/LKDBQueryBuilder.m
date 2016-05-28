//
//  LKDBQueryBuilder.m
//  wkt_app_ios
//
//  Created by junhai on 16/5/28.
//  Copyright © 2016年 junhai. All rights reserved.
//

#import "LKDBQueryBuilder.h"

@interface LKDBQueryBuilder(){

    BOOL isChanged;
    
    NSMutableString *query;
}

@end

@implementation LKDBQueryBuilder
- (instancetype)init
{
    self = [super init];
    if (self) {
        query = [NSMutableString new];
    }
    return self;
}

-(LKDBQueryBuilder *)append:(NSString *)object{
    [query appendString:object];
    return self;
}
-(LKDBQueryBuilder *)appendSpace{
    [self append:@" "];
    return self;
}
-(LKDBQueryBuilder *)appendSpaceSeparated:(NSString *)object{
    [[self append:object] appendSpace];
    return self;
}
-(LKDBQueryBuilder *)appendParenthesisEnclosed:(NSString *)object{
    [[[self append:@"("] append:object] append:@")"];
    return self;
}

-(LKDBQueryBuilder *)appendOptional:(NSString *)object{
    if(object)
        [self append:object];
    return self;
}

-(NSString *)join:(NSString *)delimiter tokens:(NSArray *)tokens{
    
    NSMutableString *sb =[NSMutableString new];
    BOOL firstTime = true;
    for (NSString *token in  tokens) {
        if (firstTime) {
            firstTime = false;
        } else {
            [sb appendString:delimiter];
        }
        [sb appendString:token];
    }
    return sb;
}


-(LKDBQueryBuilder *)appendArray:(NSArray *)objects{
    return [self append:[self join:@", " tokens:objects]];
}

-(LKDBQueryBuilder *)appendQualifier:(NSString *)name value:(NSString *)value{
    if(value.length>0){
        if(name){
            [self append:name];
        }
        [self appendSpaceSeparated:value];
    }
    
    return self;
}

-(LKDBQueryBuilder *)appendNotEmpty:(NSString *)object{
    if(object.length>0)
        [self append:object];
    return self;
}

-(NSString *)toString{
    return [self getQuery];
}
-(NSString *)getQuery{
    return query;
}


@end
