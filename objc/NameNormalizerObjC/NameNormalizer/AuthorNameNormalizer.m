#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSString *nameWithoutSuffix = [self stripSuffixFromName:name];
    NSString *trimmed = [nameWithoutSuffix stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if ([self doesNotHaveMultipleParts:parts])
        return name;
    return [NSString stringWithFormat:@"%@, %@%@%@",
                                      [self lastNameFromParts:parts],
                                      [self firstNameFromParts:parts],
                                      [self middleInitialsFromParts:parts],
                                      [self suffixForName:name]];
}

- (BOOL)doesNotHaveMultipleParts:(NSArray<NSString *> *)parts
{
    return parts.count < 2;
}

- (NSString *)stripSuffixFromName:(NSString *)name
{
    NSArray<NSString *> *prefixSuffix = [name componentsSeparatedByString:@","];
    if (prefixSuffix.count <= 1)
        return name;
    else if (prefixSuffix.count == 2)
        return prefixSuffix.firstObject;
    @throw [[NSException alloc] initWithName:@"Multiple commas" reason:nil userInfo:nil];
}

- (NSString *)suffixForName:(NSString *)name
{
    NSArray<NSString *> *prefixSuffix = [name componentsSeparatedByString:@","];
    if (prefixSuffix.count <= 1)
        return @"";
    return [NSString stringWithFormat:@",%@", prefixSuffix.lastObject];
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
    for (NSUInteger i = 1; i < parts.count - 1; ++i)
        [initials appendString:[self initialForMiddleName:parts[i]]];
    return initials;
}

- (NSString *)initialForMiddleName:(NSString *)middleName
{
    NSString *period = middleName.length > 1 ? @"." : @"";
    return [NSString stringWithFormat:@" %@%@", [middleName substringToIndex:1], period];
}

@end
