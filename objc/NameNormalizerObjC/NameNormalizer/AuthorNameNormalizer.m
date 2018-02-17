#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSArray<NSString *> *prefixSuffix = [name componentsSeparatedByString:@","];
    NSString *nameWithoutSuffix;
    NSString *suffix;
    if (prefixSuffix.count > 1) {
        nameWithoutSuffix = prefixSuffix.firstObject;
        suffix = [NSString stringWithFormat:@",%@", prefixSuffix.lastObject];
    } else {
        nameWithoutSuffix = name;
        suffix = @"";
    }
    
    NSString *trimmed = [nameWithoutSuffix stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if (parts.count < 2)
        return name;
    return [NSString stringWithFormat:@"%@, %@%@%@",
                                      [self lastNameFromParts:parts],
                                      [self firstNameFromParts:parts],
                                      [self middleInitialsFromParts:parts],
                                      suffix];
}

- (NSString *)firstNameFromParts:(NSArray<NSString *> *)parts
{
    return parts.firstObject;
}

- (NSString *)lastNameFromParts:(NSArray<NSString *> *)parts
{
    return parts.lastObject;
}

- (NSString *)middleInitialsFromParts:(NSArray<NSString *> *)parts
{
    NSMutableString *initials = [[NSMutableString alloc] init];
    for (int i = 1; i < parts.count - 1; ++i)
        [initials appendString:[self initialForMiddleName:parts[i]]];
    return initials;
}

- (NSString *)initialForMiddleName:(NSString *)middleName
{
    NSString *period = middleName.length > 1 ? @"." : @"";
    return [NSString stringWithFormat:@" %@%@", [middleName substringToIndex:1], period];
}

@end
