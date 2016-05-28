//
//  LKDBSelect.h
//  wkt_app_ios
//
//  Created by junhai on 16/5/28.
//  Copyright © 2016年 junhai. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "LKDBConditionGroup.h"
#import "LKDBSQLCondition.h"
#import "LKDBPersistenceObject.h"

#import "LKDBHelper.h"

@interface LKDBSelect : NSObject

-(instancetype)initWithHelper:(LKDBHelper *)helper;

-(instancetype)from:(Class)fromtable;

  
 
-(instancetype)where:(LKDBSQLCondition *)sqlCondition;
-(instancetype)and:(LKDBSQLCondition *)sqlCondition;
-(instancetype)or:(LKDBSQLCondition *)sqlCondition; 

//查询条件包含括号,会构造一个新的 LKDBConditionGroup,小括号包含
-(LKDBConditionGroup *)innerConditionGroup;
 
-(instancetype)orderBy:(NSArray *)orderBys;
-(instancetype)groupBy:(NSArray *)groupBys;

-(instancetype)offset:(int)offset;
-(instancetype)limit:(int)limit;


-(NSString *)getQuery;


-(NSArray<LKDBPersistenceObject *> *)queryList;
-(LKDBPersistenceObject *)querySingle;

-(NSArray *)queryOriginalList;
-(id)queryOriginaSingle;

-(int)queryCount;


@end
