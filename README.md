# LKDBSearchHelper



#####说明
* 鉴于移动端不应该存在过于复杂的查询 暂时不支持 have ， join  语法
* 支持 Swift & OC 使用
* 全面支持 NSArray,NSDictionary, ModelClass, NSNumber, NSString, NSDate, NSData, UIColor, UIImage, CGRect, CGPoint, CGSize, NSRange, int,char,float, double, long.. 等属性的自动化操作(插入和查询)

####Requirements

* iOS 7.0+
* ARC only 
* FMDB([https://github.com/ccgus/fmdb](https://github.com/ccgus/fmdb))
* LKDBHelper-SQLite-ORM([https://github.com/li6185377/LKDBHelper-SQLite-ORM](https://github.com/li6185377/LKDBHelper-SQLite-ORM))



#####引用

	source 'https://github.com/CocoaPods/Specs.git'
	source 'https://github.com/junhaiyang/Specs.git'
	 
    pod 'LKDBSearchHelper', '~> 1.0'

#####表例子(OC)

		
	#import "LKDBSearchHelper.h"
	
	@interface TestObj:LKDBPersistenceObject
	
	@property (nonatomic,strong) NSString *name;
	@property (nonatomic,assign) int key;
	@property (nonatomic,strong) NSString *ads;
	
	@end
	
	
	@implementation TestObj
	
	
	+ (NSArray *)transients{
		return @[@"ads"];  //忽略不存库
	}
	
	@end
	
#####表例子(Swift)
 
	import LKDBSearchHelper
	
	class TestObj: LKDBPersistenceObject {
    var name:NSString = "" ;
    var ads:NSString = "" ;
    
    //此方法必须实现，定义表名
    static func getTableName() -> String {
        return "TestObj"
    }
    
    open override class func transients() -> [Any] {
        return ["myname"];  //忽略不存库
    }
}
	
#####Model操作例子
	
	
    //保存
     TestObj *new_obj =[TestObj new];
     new_obj =@"1212";
     [new_obj saveToDB];
     
    //更新：被更新的对象必须是通过查询得到的
     TestObj *obj =[select querySingle];
     obj.name =@"1212";
     [obj updateToDB];
     
    //删除：被删除的对象必须是通过查询得到的
     TestObj *obj =[select querySingle];
     [obj deleteToDB];
    
    //删除表
     [TestObj dropToDB];
	
#####查询条件例子


    //生成查询，基本定义了几种类型
    
    // SELECT* FROM TestObj WHERE name='11122' AND key=123
   	LKDBSelect *select = [[[[LKDBSQLite select] from:[TestObj class]]
      where:LKDB_NotEqual_String(@"name",@"11122")]
    and:LKDB_NotEqual_Int(@"key", 123)]
                         ;
    
    NSLog(@"%@",[select getQuery]);
    
    
    // OR name='ssss' 
    [select or:LKDB_Equal_String(@"name", @"ssss")];
    
    NSLog(@"%@",[select getQuery]);
                               
    
    //生成一个AND包含条件: AND ( ...... ) 格式
    LKDBConditionGroup *andConditionGroup =[select innerAndConditionGroup];
    
    //  AND ( key=3322 OR key=8899 ) 
    [[innerAndConditionGroup where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
      
    //再生成一个 OR 包含条件: OR ( ...... ) 格式
    LKDBConditionGroup *orConditionGroup =[select innerOrConditionGroup];
    
    //  OR ( key=3322 OR key=8899 ) 
    [[innerOrConditionGroup where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
      
      
    //在包含条件里面再生成一个 OR 包含条件: OR ( ...... ) 格式
    LKDBConditionGroup *innerOrConditionGroup2 =[innerOrConditionGroup innerOrConditionGroup];
    
    //  OR ( key=3322 OR key=8899 ) 
    [[innerOrConditionGroup2 where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
    
    NSLog(@"%@",[select getQuery]);
    
    //最小结果 结果偏移
    // LIMIT 5,5 
    [[select offset:5] limit:5];
    
    NSLog(@"%@",[select getQuery]); 
    
     //查询总数
    int count =[select queryCount];
    
     //查询多个结果
    NSArray* list = [select queryList];
    
     //查询单个结果
    TestObj *obj =[select querySingle];
    
     
     
#####删除条件使用例子


    //生成删除条件，基本定义了几种类型
    
    // DELETE FROM TestObj WHERE name='11122' AND key=123
   	LKDBDelete *deleteQuery = [[[[LKDBSQLite delete] from:[TestObj class]]
      where:LKDB_NotEqual_String(@"name",@"11122")]
    and:LKDB_NotEqual_Int(@"key", 123)]
                         ;
    
    NSLog(@"%@",[deleteQuery getQuery]);
    
    
    // OR name='ssss' 
    [deleteQuery or:LKDB_Equal_String(@"name", @"ssss")];
    
    NSLog(@"%@",[deleteQuery getQuery]);
                               
    
    //生成一个AND包含条件: AND ( ...... ) 格式
    LKDBConditionGroup *andConditionGroup =[deleteQuery innerAndConditionGroup];
    
    //  AND ( key=3322 OR key=8899 ) 
    [[innerAndConditionGroup where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
      
    //再生成一个 OR 包含条件: OR ( ...... ) 格式
    LKDBConditionGroup *orConditionGroup =[select innerOrConditionGroup];
    
    //  OR ( key=3322 OR key=8899 ) 
    [[innerOrConditionGroup where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
      
      
    //在包含条件里面再生成一个 OR 包含条件: OR ( ...... ) 格式
    LKDBConditionGroup *innerOrConditionGroup2 =[innerOrConditionGroup innerOrConditionGroup];
    
    //  OR ( key=3322 OR key=8899 ) 
    [[innerOrConditionGroup2 where:LKDB_Equal_Int(@"key", 3322)]
      or:LKDB_Equal_Int(@"key", 8899)]];
    
    NSLog(@"%@",[deleteQuery getQuery]);  
    
     //执行删除
     [deleteQuery execute]; 
    
    
    
    
     
#####事物操作例子
	
	
     //事物操作
    [LKDBSQLite executeForTransaction:^BOOL(void) {
        
        [[LKDBSQLite select] from:[TestObj class]] .........
        
        return YES; //YES 为提交事务，NO 取消事务
    }];
    
    或
     
     //事物操作
    [[LKDBSQLite transaction] executeForTransaction:^BOOL(void) {
        
        [[LKDBSQLite select] from:[TestObj class]] .........
        
        return YES; //YES 为提交事务，NO 取消事务
    }];
    
    model直接操作
    
    LKDBTransaction * transaction = [LKDBSQLite transaction];
    
    [[[transaction  update:obj]  insert:obj]  delete:obj];
    
    [transaction  updateAll:objs];
    [transaction  insertAll:objs];
    [transaction  deleteAll:objs];
    
    [transaction execute];  //会严格按照操作调用顺序执行
     
    
    
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
	LKDB_Condition(name,operation,value)    //value 是String ，如果是处理字符串 得加上单引号和转义,数字类型就直接生成String 就可以    
