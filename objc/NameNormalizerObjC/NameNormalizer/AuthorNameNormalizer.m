#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSString *trimmed = [name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    NSArray<NSString *> *parts = [trimmed componentsSeparatedByString:@" "];
    if (parts.count < 2)
        return name;
    return [NSString stringWithFormat:@"%@, %@%@",
                                      [self lastNameFromParts:parts],
                                      [self firstNameFromParts:parts],
                                      [self middleInitialFromParts:parts]];
}

- (NSString *)firstNameFromParts:(NSArray<NSString *> *)parts
{
    return parts.firstObject;
}

- (NSString *)lastNameFromParts:(NSArray<NSString *> *)parts
{
    return parts.lastObject;
}

- (NSString *)middleInitialFromParts:(NSArray<NSString *> *)parts
{
    NSString *initials = @"";
    for (int i = 1; i < parts.count - 1; ++i)
        initials = [initials stringByAppendingString:[self initialForMiddleName:parts[i]]];
    return initials;
}

- (NSString *)initialForMiddleName:(NSString *)middleName
{
    NSString *period = middleName.length > 1 ? @"." : @"";
    return [NSString stringWithFormat:@" %@%@", [middleName substringToIndex:1], period];
}

@end
