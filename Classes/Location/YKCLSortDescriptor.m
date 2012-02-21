//
//  YKCLSortDescriptor.m
//  YelpKit
//
//  Created by Gabriel Handford on 9/16/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "YKCLSortDescriptor.h"

#import "YKCLUtils.h"

@implementation YKCLSortDescriptor

- (id)initWithAscending:(BOOL)ascending coordinate:(CLLocationCoordinate2D)coordinate {
  if ((self = [super initWithKey:nil ascending:ascending])) {
    _coordinate = coordinate;
  }
  return self;
}

- (id)initWithLatitudeKey:(NSString *)latitudeKey longitudeKey:(NSString *)longitudeKey ascending:(BOOL)ascending coordinate:(CLLocationCoordinate2D)coordinate {
  if ((self = [super initWithKey:nil ascending:ascending])) {
    _coordinate = coordinate;
    _latitudeKey = [latitudeKey retain];
    _longitudeKey = [longitudeKey retain];
  }
  return self;
}

- (void)dealloc {
  [_latitudeKey release];
  [_longitudeKey release];
  [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone {
  if (_latitudeKey && _longitudeKey) {
    return [[YKCLSortDescriptor allocWithZone:zone] initWithLatitudeKey:_latitudeKey longitudeKey:_longitudeKey ascending:[self ascending] coordinate:_coordinate];
  } else {
    return [[YKCLSortDescriptor allocWithZone:zone] initWithAscending:[self ascending] coordinate:_coordinate];    
  }
}

- (id)reversedSortDescriptor {
  if (_latitudeKey && _longitudeKey) {
    return [[[YKCLSortDescriptor alloc] initWithLatitudeKey:_latitudeKey longitudeKey:_longitudeKey ascending:![self ascending] coordinate:_coordinate] autorelease];
  } else {
    return [[[YKCLSortDescriptor alloc] initWithAscending:![self ascending] coordinate:_coordinate] autorelease];
    
  }
}

- (NSComparisonResult)compareObject:(id)object1 toObject:(id)object2 {
  
  BOOL hasCoordinate1;
  BOOL hasCoordinate2;
  CLLocationCoordinate2D coordinate1;
  CLLocationCoordinate2D coordinate2;
  
  if (_latitudeKey && _longitudeKey) {
    NSNumber *latitudeNumber1 = [object1 valueForKeyPath:_latitudeKey];
    NSNumber *longitudeNumber1 = [object1 valueForKeyPath:_longitudeKey];
    hasCoordinate1 = (latitudeNumber1 && longitudeNumber1);
    
    NSNumber *latitudeNumber2 = [object2 valueForKeyPath:_latitudeKey];
    NSNumber *longitudeNumber2 = [object2 valueForKeyPath:_longitudeKey];
    hasCoordinate2 = (latitudeNumber2 && longitudeNumber2);
    
    if (hasCoordinate1)
      coordinate1 = YKCLLocationCoordinate2DMake([latitudeNumber1 doubleValue], [longitudeNumber1 doubleValue]);
    if (hasCoordinate2)
      coordinate2 = YKCLLocationCoordinate2DMake([latitudeNumber2 doubleValue], [longitudeNumber2 doubleValue]);    
  } else {
    coordinate1 = [object1 coordinate];
    coordinate2 = [object2 coordinate];
    hasCoordinate1 = !YKCLLocationCoordinate2DIsNull(coordinate1);
    hasCoordinate2 = !YKCLLocationCoordinate2DIsNull(coordinate2);
  }
  
  NSComparisonResult result;
  
  if (!hasCoordinate1 && !hasCoordinate2) result = NSOrderedSame;
  else if (hasCoordinate1 && !hasCoordinate2) result = NSOrderedAscending;
  else if (!hasCoordinate1 && hasCoordinate2) result = NSOrderedDescending;
  else {
    CLLocationDistance d1 = YKCLLocationCoordinateDistance(_coordinate, coordinate1, YES);
    CLLocationDistance d2 = YKCLLocationCoordinateDistance(_coordinate, coordinate2, YES);
    
    if (d1 < d2) result = NSOrderedAscending;
    else if (d1 > d2) result = NSOrderedDescending;
    else result = NSOrderedSame;
  }
  
  if (![self ascending]) {
    if (result == NSOrderedAscending) result = NSOrderedDescending;
    else if (result == NSOrderedDescending) result = NSOrderedAscending;
  } 
  return result;
}

@end
