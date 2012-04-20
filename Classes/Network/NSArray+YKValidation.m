//
//  NSArray+YKValidation.m
//  YelpKit
//
//  Created by John Boiles on 4/19/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSArray+YKValidation.h"
#import "YKValidationException.h"

@implementation NSArray (YKValidation)

- (id)yk_objectAtIndex:(NSInteger)index {
  if (index >= [self count]) {
    NSString *reason = [NSString stringWithFormat:@"Object out of range at index %d (%d elements in array).", index, [self count]];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self forKey:@"array"];
    @throw [[YKValidationException alloc] initWithName:@"YKValidationException" reason:reason userInfo:userInfo];
  }
  id object = [self objectAtIndex:index];
  if (object == [NSNull null] || [object isEqual:[NSNull null]])
    return nil;
  return object;
}

- (id)yk_validatedObjectMaybeNilAtIndex:(NSInteger)index expectedClass:(Class)expectedClass {
  id object = [self yk_objectAtIndex:index];
  if (object && ![object isKindOfClass:expectedClass]) {
    NSString *reason = [NSString stringWithFormat:@"Object at index '%d' should have been %@ but was %@.", index, NSStringFromClass(expectedClass), NSStringFromClass([object class])];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self forKey:@"array"];
    @throw [[YKValidationException alloc] initWithName:@"YKValidationException" reason:reason userInfo:userInfo];
  }
  return object;
}

- (id)yk_NSStringMaybeNilAtIndex:(NSInteger)index {
  return [self yk_validatedObjectMaybeNilAtIndex:index expectedClass:[NSString class]];
}

- (id)yk_NSStringOrNSNumberMaybeNilAtIndex:(NSInteger)index {
  id object = [self yk_objectAtIndex:index];
  if (object && ![object isKindOfClass:[NSString class]] && ![object isKindOfClass:[NSNumber class]]) @throw [[YKValidationException alloc] initWithName:@"YKValidationException" reason:[NSString stringWithFormat:@"Object was supposed to be NSString or NSNumber but was %@", NSStringFromClass([object class])] userInfo:nil];
  return object;
}

- (id)yk_NSNumberMaybeNilAtIndex:(NSInteger)index {
  return [self yk_validatedObjectMaybeNilAtIndex:index expectedClass:[NSNumber class]];
}

- (id)yk_NSArrayMaybeNilAtIndex:(NSInteger)index {
  return [self yk_validatedObjectMaybeNilAtIndex:index expectedClass:[NSArray class]];
}

- (id)yk_NSDictionaryMaybeNilAtIndex:(NSInteger)index {
  return [self yk_validatedObjectMaybeNilAtIndex:index expectedClass:[NSDictionary class]];
}

@end
