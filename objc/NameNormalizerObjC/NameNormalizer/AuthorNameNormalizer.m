#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSString *trimmed = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if (parts.count < 2)
        return name;
    return [NSString stringWithFormat:@"%@, %@%@", [self lastNameFromParts:parts], parts.firstObject, [self middleInitialFromParts:parts]];
}

- (NSString *)lastNameFromParts:(NSArray<NSString *> *)parts
{
    return parts.lastObject;
}

- (NSString *)middleInitialFromParts:(NSArray<NSString *> *)parts
{
    if (parts.count > 2)
        return [NSString stringWithFormat:@" %@.", [parts[1] substringToIndex:1]];
    return @"";
}

@end
