# LKDBSearchHelper



#####说明
* 鉴于移动端不应该存在过于复杂的查询 暂时不支持 have ， join  语法



#####引用

	source 'https://github.com/CocoaPods/Specs.git'
	source 'https://github.com/junhaiyang/Specs.git'
	 
    pod 'LKDBSearchHelper', '~> 1.0'

#####表例子

		
	#import "LKDBSearchHelper.h"
	
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
      where:LKDB_NotEqual_String(@"name",@"11122")]
    and:LKDB_NotEqual_Int(@"key", 123)]
                         ;
    
    NSLog(@"%@",[select getQuery]);
    
    
    [select or:LKDB_Equal_String(@"name", @"ssss")];
    
    NSLog(@"%@",[select getQuery]);
    
    //生成一个包含条件 (......) 格式
    LKDBConditionGroup *innerConditionGroup =[select innerConditionGroup];
    
    [[innerConditionGroup where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
    
    NSLog(@"%@",[select getQuery]);
    //最小结果 结果偏移
    [[select offset:5] limit:5];
    
    NSLog(@"%@",[select getQuery]); 
    
     //查询总数
    int count =[select queryCount];
    
     //查询多个结果
    NSArray* list = [select queryList];
    
     //查询单个结果
    TestObj *obj =[select querySingle];
    
    
    
     //事物操作
    [LKDBSQLite executeForTransaction:^BOOL(void) {
        
        [[LKDBSQLite select] from:[TestObj class]] .........
        
        return YES; //YES 为提交事务，NO 取消事务
    }];
    
    
    
    //保存
     [obj saveToDB];
     
    //更新
     [obj updateToDB];
     
    //删除
     [obj deleteToDB];
    
    //删除表
     [TestObj dropToDB];
    
#####条件说明

		
		
	//基本条件语句

	//条件等于
	LKDB_Equal_String(name,value)   
 	LKDB_Equal_Int(name,value)     
	LKDB_Equal_Float(name,value)        



	//条件不等于
	LKDB_NotEqual_String(name,value)    
	LKDB_NotEqual_Int(name,value)        
	LKDB_NotEqual_Float(name,value)     



	//字符串 IS NOT
	LKDB_IsNot_String(name,value)     
	//字符串LIKE
	LKDB_LIKE_String(name,value)         

	//条件小于
	LKDB_LessThan_String(name,value)   
	LKDB_LessThan_Int(name,value)        
	LKDB_LessThan_Float(name,value)    

	//条件大于
	LKDB_GreaterThan_String(name,value)        
	LKDB_GreaterThan_Int(name,value)      
	LKDB_GreaterThan_Float(name,value)       

	//条件小于等于
	LKDB_LessAndEqualThan_String(name,value) 
	LKDB_LessAndEqualThan_Int(name,value)            
	LKDB_LessAndEqualThan_Float(name,value)    

	//条件大于等于
	LKDB_GreaterAndEqualThan_String(name,value)             
	LKDB_GreaterAndEqualThan_Int(name,value)           
	LKDB_GreaterAndEqualThan_Float(name,value)         
	                  

	//IN条件 
	LKDB_IN_String(name,values)    
	LKDB_IN_Int(name,values)   
	
	

	//基本条件
	LKDB_Condition(name,operation,value)    //value 是String ，如果是处理字符串 得加上单引号和转移,数字类型就直接生成String 就可以    
