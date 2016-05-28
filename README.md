# LKDBSearchHelper

#####遗留问题
* 暂时不支持 have ， join ，in 语法




#####表例子

		
	#import "LKDBPersistenceObject.h"
	
	@interface TestObj:LKDBPersistenceObject
	
	@property (nonatomic,strong) NSString *name;
	@property (nonatomic,assign) int key;
	@property (nonatomic,strong) NSString *ads;
	
	@end
	
	
	@implementation LKDBSQLCondition
	
	
	+ (NSArray *)transients{
		return @[@"ads"];  //忽略不存库
	}
	
	@end
	
	
#####使用例子


    //生成查询，基本定义了几种类型 ，
   	LKDBSelect *select = [[[[LKDBSQLite select] from:[TestObj class]]
      where:LKDB_NotEqualString(@"name",@"11122")]
    and:LKDB_NotEqualInt(@"key", 123)]
                         ;
    
    NSLog(@"%@",[select getQuery]);
    
    
    [select or:LKDB_EqualString(@"name", @"ssss")];
    
    NSLog(@"%@",[select getQuery]);
    
    //生成一个包含条件 (......) 格式
    LKDBConditionGroup *innerConditionGroup =[select innerConditionGroup];
    
    [innerConditionGroup where:LKDB_EqualInt(@"key", 3322)];
    [innerConditionGroup or:LKDB_EqualInt(@"key", 8899)];
    
    NSLog(@"%@",[select getQuery]);
    //最小结果
    [select limit:5];
    
    NSLog(@"%@",[select getQuery]);
    //结果偏移
    [select offset:5];
    
    NSLog(@"%@",[select getQuery]);
    
     //查询总数
    int count =[select queryCount];
    
     //查询多个结果
    NSArray* list = [select queryList];
    
     //查询单个结果
    TestObj *obj =[select querySingle];
    
    
    
     //事物操作
    [LKDBSQLite executeForTransaction:^BOOL(LKDBHelper *helper) {
        
        [[LKDBSQLite select:helper] from:[TestObj class]] .........
        
        return YES;
    }];
    
    
#####条件说明

		
		
	//基本条件语句

	//条件等于
	LKDB_EqualString(name,value)   
 	LKDB_EqualInt(name,value)     
	LKDB_EqualFloat(name,value)     
	LKDB_EqualDouble(name,value)      
	LKDB_EqualLong(name,value)          
	LKDB_EqualLongLong(name,value)    



	//条件不等于
	LKDB_NotEqualString(name,value)    
	LKDB_NotEqualInt(name,value)        
	LKDB_NotEqualFloat(name,value)   
	LKDB_NotEqualDouble(name,value)    
	LKDB_NotEqualLong(name,value)    
	LKDB_NotEqualLongLong(name,value)    



	//字符串不等于
	LKDB_IsNotString(name,value)     
	//字符串LIKE
	LKDB_LIKEString(name,value)         

	//条件小于
	LKDB_LessThanString(name,value)   
	LKDB_LessThanInt(name,value)        
	LKDB_LessThanFloat(name,value)   
	LKDB_LessThanDouble(name,value)    
	LKDB_LessThanLong(name,value)   
	LKDB_LessThanLongLong(name,value)  

	//条件大于
	LKDB_GreaterThanString(name,value)        
	LKDB_GreaterThanInt(name,value)      
	LKDB_GreaterThanFloat(name,value)      
	LKDB_GreaterThanDouble(name,value)   
	LKDB_GreaterThanLong(name,value)  
	LKDB_GreaterThanLongLong(name,value)   

	//条件小于等于
	LKDB_LessAndEqualThanString(name,value) 
	LKDB_LessAndEqualThanInt(name,value)            
	LKDB_LessAndEqualThanFloat(name,value)   
	LKDB_LessAndEqualThanDouble(name,value)  
	LKDB_LessAndEqualThanLong(name,value)         
	LKDB_LessAndEqualThanLongLong(name,value)    

	//条件大于等于
	LKDB_GreaterAndEqualThanString(name,value)             
	LKDB_GreaterAndEqualThanInt(name,value)           
	LKDB_GreaterAndEqualThanFloat(name,value)           
	LKDB_GreaterAndEqualThanDouble(name,value)            
	LKDB_GreaterAndEqualThanLong(name,value)             
	LKDB_GreaterAndEqualThanLongLong(name,value)            
