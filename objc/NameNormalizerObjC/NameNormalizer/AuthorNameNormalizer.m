#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSString *trimmed = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if (parts.count < 2)
        return name;
    NSString *middleInitial = [self middleInitialFromParts:parts];
    return [NSString stringWithFormat:@"%@, %@%@", parts.lastObject, parts.firstObject, middleInitial];
}

- (NSString *)middleInitialFromParts:(NSArray<NSString *> *)parts
{
    if (parts.count > 2)
        return [NSString stringWithFormat:@" %@.", [parts[1] substringToIndex:1]];
    return @"";
}

@end
