//
//  NSDictionary+YKValidation.m
//  YelpKit
//
//  Created by John Boiles on 4/18/12.
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

#import "NSDictionary+YKValidation.h"
#import "YKValidationException.h"


@implementation NSDictionary (YKUtils)

- (id)yk_objectMaybeNilForKey:(id)key {
  id object = [self objectForKey:key];
  if (object == [NSNull null] || [object isEqual:[NSNull null]])
    return nil;
  return object;
}

- (id)yk_objectMaybeNilAtLine:(NSInteger)line inFile:(char *)file forKey:(NSString *)key {
  id object = [self yk_objectMaybeNilForKey:key];
  if (object) NSLog(@"HEY! Found an unvalidated field! %s:%d was kind of class %@.", file, line, [object class]);
  return object;
}

- (id)yk_validatedObjectMaybeNilForKey:(id)key expectedClass:(Class)expectedClass {
  id object = [self yk_objectMaybeNilForKey:key];
  if (object && ![object isKindOfClass:expectedClass]) {
    NSString *reason = [NSString stringWithFormat:@"Object for key '%@' should have been %@ but was %@.", key, NSStringFromClass(expectedClass), NSStringFromClass([object class])];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self forKey:@"dictionary"];
    @throw [[YKValidationException alloc] initWithName:@"YKValidationException" reason:reason userInfo:userInfo];
  }
  return object;
}

- (id)yk_NSStringMaybeNilForKey:(id)key {
  return [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSString class]];
}

- (id)yk_NSStringOrNSNumberMaybeNilForKey:(id)key {
  id object = [self yk_objectMaybeNilForKey:key];
  if (object && ![object isKindOfClass:[NSString class]] && ![object isKindOfClass:[NSNumber class]]) {
    NSString *reason = [NSString stringWithFormat:@"Object was supposed to be NSString or NSNumber but was %@", NSStringFromClass([object class])];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:self forKey:@"dictionary"];
    @throw [[YKValidationException alloc] initWithName:@"YKValidationException" reason:reason userInfo:userInfo];
  }
  return object;
}

- (id)yk_NSNumberMaybeNilForKey:(id)key {
  return [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSNumber class]];
}

- (id)yk_NSArrayMaybeNilForKey:(id)key {
  return [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSArray class]];
}

- (id)yk_NSDictionaryMaybeNilForKey:(id)key {
  return [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSDictionary class]];
}

- (double)yk_doubleForKey:(id)key withDefault:(double)defaultValue {
  id value = [self yk_NSStringOrNSNumberMaybeNilForKey:key];
	if (!value) return defaultValue;
	return [value doubleValue];
}

- (double)yk_doubleForKey:(id)key {
	return [self yk_doubleForKey:key withDefault:0];
}

- (NSInteger)yk_integerForKey:(id)key withDefault:(NSInteger)defaultValue {
	id value = [self yk_NSStringOrNSNumberMaybeNilForKey:key];
	if (!value) return defaultValue;
	return [value integerValue];
}

- (NSInteger)yk_integerForKey:(id)key {
	return [self yk_integerForKey:key withDefault:0];
}

- (NSUInteger)yk_unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue {
	NSNumber *value = [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSNumber class]];
	if (!value) return defaultValue;
	return [value unsignedIntegerValue];
}

- (NSUInteger)yk_unsignedIntegerForKey:(id)key {
	return [self yk_unsignedIntegerForKey:key withDefault:0];
}

- (NSNumber *)yk_numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue {
	NSNumber *value = [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSNumber class]];
	if (!value) return [NSNumber numberWithInteger:defaultValue];
	return value;
}

- (NSNumber *)yk_numberForKey:(id)key withDefaultDouble:(double)defaultValue {
	NSNumber *value = [self yk_validatedObjectMaybeNilForKey:key expectedClass:[NSNumber class]];
	if (!value) return [NSNumber numberWithDouble:defaultValue];
	return value;
}

- (BOOL)yk_boolForKey:(id)key withDefault:(BOOL)defaultValue {
  id value = [self yk_NSStringOrNSNumberMaybeNilForKey:key];
	if (!value) return defaultValue;
	return [value boolValue];
}

- (BOOL)yk_boolForKey:(id)key {
	return [self yk_boolForKey:key withDefault:NO];
}

- (NSNumber *)yk_boolValueForKey:(id)key withDefault:(BOOL)defaultValue {
	id value = [self yk_NSStringOrNSNumberMaybeNilForKey:key];
	if (!value) return [NSNumber numberWithBool:defaultValue];
	return [NSNumber numberWithBool:[value boolValue]];
}

- (NSNumber *)yk_boolValueForKey:(id)key {
	return [self yk_boolValueForKey:key withDefault:NO];
}

@end
