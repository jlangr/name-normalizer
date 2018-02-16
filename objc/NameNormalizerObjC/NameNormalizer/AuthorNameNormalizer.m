#import "AuthorNameNormalizer.h"

@implementation AuthorNameNormalizer

- (NSString *)normalize:(NSString *)name
{
    NSArray<NSString *> *parts = [name componentsSeparatedByString:@" "];
    if (parts.count > 1)
        return [NSString stringWithFormat:@"%@, %@", parts.lastObject, parts.firstObject];
    return name;
}

@end
