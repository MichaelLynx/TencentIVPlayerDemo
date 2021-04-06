
#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
- (NSString *)description
{
    /*NSMutableString *strM = [NSMutableString stringWithString:@"\n{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]])
        {
            [strM appendFormat:@" %@ = %@,\n", key, obj];
        }
        else
        {
            [strM appendFormat:@" %@ = %@,\n", key, [obj description]];
        }
    }];
    [strM appendString:@"}"];*/
    return [self descriptionWithLocale:self];
}
@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
- (NSString *)description{
//    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[NSString class]])
//        {
//            [strM appendFormat:@"\t\t%@,\n", obj];
//        }
//        else
//        {
//            [strM appendFormat:@"\t\t%@,\n", [obj description]];
//        }
//    }];
//    [strM appendString:@"\t\t)"];
      return [self descriptionWithLocale:self];;
}
@end
