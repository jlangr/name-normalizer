#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSString *trimmed = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if (parts.count > 2)
    {
        NSString *middleInitial = [parts[1] substringToIndex:1];
        return [NSString stringWithFormat:@"%@, %@ %@.", parts.lastObject, parts.firstObject, middleInitial];
    }
    if (parts.count > 1)
        return [NSString stringWithFormat:@"%@, %@", parts.lastObject, parts.firstObject];
    return name;
}

@end
