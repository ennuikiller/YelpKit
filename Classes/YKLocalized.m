//
//  YKLocalized.m
//  YelpIPhone
//
//  Created by Gabriel Handford on 11/18/08.
//  Copyright 2008 Yelp. All rights reserved.
//

#import "YKLocalized.h"
#import "YKDefines.h"


#include <math.h>

#define kDefaultTableName @"Localizable"
static NSString *gDefaultTableName = kDefaultTableName;

@implementation NSBundle (YKLocalized)

// Get resource cache
+ (NSMutableDictionary *)yelp_localizationResourceCache {
  static NSMutableDictionary *LocalizationResourceCache = nil;
  @synchronized([YKLocalized class]) {
    if (!LocalizationResourceCache) LocalizationResourceCache = [[NSMutableDictionary alloc] init];
  }
  return LocalizationResourceCache;
}

+ (NSMutableDictionary *)yelp_pathForResourceCache {
  static NSMutableDictionary *PathForResourceCache = nil;
  @synchronized([YKLocalized class]) {    
    if (!PathForResourceCache) PathForResourceCache = [[NSMutableDictionary alloc] init];
  }
  return PathForResourceCache;
}

// Clear resource cache
+ (void)yelp_clearCache {
  [[self yelp_localizationResourceCache] removeAllObjects];
}

// Cached version of path for resource
- (NSString *)yelp_pathForResource:(NSString *)tableName localization:(NSString *)localization {
  if ([localization isEqual:@"en_US"]) localization = @"en";
  NSString *key = [[NSString alloc] initWithFormat:@"%@%@", tableName, localization];
  id resource = [[NSBundle yelp_pathForResourceCache] objectForKey:key];
  if ([resource isEqual:[NSNull null]]) return nil;
  
  if (!resource) {
    resource = [self pathForResource:tableName ofType:@"strings" inDirectory:nil forLocalization:localization];
    [[NSBundle yelp_pathForResourceCache] setObject:(resource ? resource : [NSNull null]) forKey:key];
  }
  
  [key release];
  return (NSString *)resource;
}

- (NSDictionary *)yelp_loadResourceForTableName:(NSString *)tableName localization:(NSString *)localization {
  NSDictionary *dict = nil;
  if ([localization isEqual:@"en_US"]) localization = @"en";
  NSString *key = [[NSString alloc] initWithFormat:@"%@%@", tableName, localization];  
  dict = [[NSBundle yelp_localizationResourceCache] objectForKey:key];
  if (!dict) {
    NSString *resource = [self yelp_pathForResource:tableName localization:localization];
    if (!resource) return nil;
    dict = [[NSDictionary alloc] initWithContentsOfFile:resource];
    [[NSBundle yelp_localizationResourceCache] setObject:dict forKey:key];
    [dict release];
  }
  [key release];
  return dict;
}

// Look for string with localization string
- (NSString *)yelp_stringForKey:(NSString *)key tableName:(NSString *)tableName localization:(NSString *)localization {
  if (!localization) localization = [YKLocalized languageCode];

  
  NSDictionary *dict = [self yelp_loadResourceForTableName:tableName localization:localization];
  return [dict objectForKey:key];
}

- (NSString *)yelp_preferredLanguageForTableName:(NSString *)tableName {
  static NSString *LanguageCode = nil;
  if (LanguageCode) return LanguageCode;
  
  for (NSString *languageCode in [NSLocale preferredLanguages]) {
    // Check if we have a bundle with this preferred language code
    if (!![self yelp_loadResourceForTableName:tableName localization:languageCode]) {
      LanguageCode = [languageCode copy];
      break;
    }
  }
  if (!LanguageCode) LanguageCode = @"en";
  return LanguageCode;
}

// Patched localized string.
- (NSString *)yelp_localizedStringForKey:(NSString *)key value:(NSString *)value tableName:(NSString *)tableName {
  if (!key) {
    YKInfo(@"Trying to localize nil key, (with value=%@, tableName=%@)", value, tableName);
    return nil;
  }

  NSString *localizedString = [[YKLocalized localizationCache] objectForKey:key];
  if (localizedString) return localizedString;
  
  if (!tableName) tableName = gDefaultTableName; // Default file is Localizable.strings

  localizedString = [self yelp_localizedStringForKey:key tableName:tableName];
  
  if (!localizedString) {
    localizedString = value;
  }

  if (!localizedString) {
    localizedString = key;
  }
   
  if (localizedString) {
    [[YKLocalized localizationCache] setObject:localizedString forKey:key];
  }
  
  return localizedString;
}

- (NSString *)yelp_localizedStringForKey:(NSString *)key tableName:(NSString *)tableName {
  NSString *localizedString = [self yelp_stringForKey:key tableName:tableName localization:[YKLocalized localeIdentifier]];
  
  // If not found, check preferredLanguages
  if (!localizedString)
    localizedString = [self yelp_stringForKey:key tableName:tableName localization:[self yelp_preferredLanguageForTableName:tableName]];
  
  return localizedString;
}


@end

@implementation YKLocalized

static NSMutableDictionary *gLocalizationCache = nil;
static NSString *gLocaleIdentifier = nil;
static NSSet *gSupportedLanguages = nil;
static NSString *gLanguageCode = nil;

+ (NSMutableDictionary *)localizationCache {
  @synchronized([YKLocalized class]) {
    if (!gLocalizationCache) gLocalizationCache = [[NSMutableDictionary alloc] init];
  }
  return gLocalizationCache;
}

+ (void)clearCache {
  [NSBundle yelp_clearCache];
  [gLocalizationCache release];
  gLocalizationCache = nil;
  [gLocaleIdentifier release];
  gLocaleIdentifier = nil;
  [gLanguageCode release];
  gLanguageCode = nil;
}

+ (NSString *)localize:(NSString *)key tableName:(NSString *)tableName value:(NSString *)value {
  return NSLocalizedStringWithDefaultValue(key, tableName, [NSBundle bundleForClass:[self class]], value, @"");
}

+ (void)setDefaultTableName:(NSString *)defaultTableName {
  [gDefaultTableName release];
  gDefaultTableName = (defaultTableName ? [defaultTableName copy] : kDefaultTableName);
}

+ (BOOL)isMetric {
  return [self isMetric:[NSLocale currentLocale]];
}

+ (BOOL)isMetric:(id)locale {
  // Override metric for GB (use miles)
  if ([[self countryCode] isEqualToString:@"GB"]) return NO;
  
  return [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
}

+ (NSString *)currencySymbol {
  // Special casing Switzerland and Sweden currency symbols to be
  // $ so filters don't look ghetto.
  if ([[self countryCode] isEqualToString:@"CH"]) return @"$";
  if ([[self countryCode] isEqualToString:@"SE"]) return @"$";
  return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}

+ (NSString *)localeIdentifier {
  if (!gLocaleIdentifier) {
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if (countryCode) gLocaleIdentifier = [[NSString stringWithFormat:@"%@_%@", [YKLocalized languageCode], countryCode] retain];
    else gLocaleIdentifier = [[YKLocalized languageCode] retain];
    YKDebug(@"gLocaleIdentifier: %@", gLocaleIdentifier);
  }
  return gLocaleIdentifier;
}

+ (NSSet *)supportedLanguages {
  return gSupportedLanguages;
}

+ (void)setSupportedLanguages:(NSSet *)supportedLanguages {
  [supportedLanguages retain];
  [gSupportedLanguages release];
  gSupportedLanguages = supportedLanguages;
}

+ (NSString *)countryCode {
  return [[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleCountryCode];
}

+ (NSString *)languageCode {
  if (!gLanguageCode) {
    NSArray *preferredLanguages = [NSLocale preferredLanguages];
    NSSet *supportedLanguages = [YKLocalized supportedLanguages];
    for (NSString *language in preferredLanguages) {
      if (!supportedLanguages || [supportedLanguages containsObject:language]) {
        gLanguageCode = [language retain];
        return gLanguageCode;
      }
    }
    gLanguageCode = [@"en" retain];
  }
  return gLanguageCode;
}

+ (BOOL)isCountryCode:(NSString *)code {
  NSString *countryCode = [self countryCode];
  return ([countryCode compare:code options:NSCaseInsensitiveSearch] == NSOrderedSame);
}

+ (NSString *)localizedPath:(NSString *)name ofType:(NSString *)type {
  NSString *localeIdentifier = [YKLocalized localeIdentifier];
  
  NSString *resourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type inDirectory:nil forLocalization:localeIdentifier];
  // Try a localization for the language code
  if (!resourcePath) resourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type inDirectory:nil forLocalization:[YKLocalized languageCode]];
  // Try localizing based on 'en'
  if (!resourcePath) resourcePath = [[NSBundle mainBundle] pathForResource:name ofType:type inDirectory:nil forLocalization:@"en"];
  // If a localized version was found, remove the base resource path
  if (resourcePath) {
    NSString *baseResourcePath = [[NSBundle mainBundle] resourcePath];
    resourcePath = [resourcePath substringFromIndex:[baseResourcePath length] + 1];
  // Otherwise just return the filename
  } else {
    resourcePath = [NSString stringWithFormat:@"%@.%@", name, type];
  }
  return resourcePath;
}

+ (NSString *)localizedListFromStrings:(NSArray */*of NSString*/)strings {
  if (!strings || ([strings count] <= 0)) return nil;
  if ([strings count] == 1) return [strings objectAtIndex:0];
  if ([strings count] == 2) {
    return [NSString stringWithFormat:@"%@ %@ %@", [strings objectAtIndex:0], YKLocalizedString(@"and"), [strings objectAtIndex:1], nil];
  }
  NSMutableString *localizedList = [[[NSMutableString alloc] initWithString:[strings objectAtIndex:0]] autorelease];
  for (NSInteger i = 1; i < [strings count]; i++) {
    if (i == ([strings count] - 1)) [localizedList appendFormat:@" %@ ", YKLocalizedString(@"and"), nil];
    else [localizedList appendString:@", "];
    [localizedList appendString:[strings objectAtIndex:i]];
  }
  return localizedList;
}

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setLocale:[YKLocalized currentLocale]];
  return [formatter autorelease];
}

+ (NSLocale *)currentLocale {
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[YKLocalized localeIdentifier]];
  return [locale autorelease];
}

@end

