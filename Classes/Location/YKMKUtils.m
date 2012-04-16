//
//  YKMKUtils.m
//  YelpKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "YKMKUtils.h"
#import "YKCLUtils.h"
#import "YKCGUtils.h"
#import "YKMKAnnotation.h"
#import <GHKitIOS/GHNSDictionary+Utils.h>
#import <GHKitIOS/GHNSDictionary+NSNull.h>


NSString *YKNSStringFromMKCoordinateSpan(MKCoordinateSpan span) {
  return [NSString stringWithFormat:@"(Δ%0.6f, Δ%0.6f)", span.latitudeDelta, span.longitudeDelta];
}

NSString *YKNSStringFromMKCoordinateRegion(MKCoordinateRegion region) {
  if (YKMKCoordinateRegionIsNull(region)) return @"(null)";
  return [YKNSStringFromCLLocationCoordinate2D(region.center) stringByAppendingFormat:@" %@", YKNSStringFromMKCoordinateSpan(region.span)];
}

MKCoordinateRegion YKMKCoordinateRegionInset(MKCoordinateRegion region, CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta) {
  MKCoordinateRegion insetRegion = region;
  insetRegion.span.latitudeDelta -= latitudeDelta;
  insetRegion.span.longitudeDelta -= longitudeDelta;
  return insetRegion;
}

BOOL YKMKCoordinateSpanIsEqual(MKCoordinateSpan s1, MKCoordinateSpan s2, CLLocationDegrees accuracy) {
  return YKIsEqualWithAccuracy(s1.latitudeDelta, s2.latitudeDelta, accuracy) && YKIsEqualWithAccuracy(s1.longitudeDelta, s2.longitudeDelta, accuracy);
}

BOOL YKMKCoordinateSpanIsSimilar(MKCoordinateSpan s1, MKCoordinateSpan s2, double spanAccuracyPercentage) {
  CLLocationDegrees latitudeAccuracy = (s1.latitudeDelta * spanAccuracyPercentage);
  CLLocationDegrees longitudeAccuracy = (s1.longitudeDelta * spanAccuracyPercentage);
  return YKIsEqualWithAccuracy(s1.latitudeDelta, s2.latitudeDelta, latitudeAccuracy) && YKIsEqualWithAccuracy(s1.longitudeDelta, s2.longitudeDelta, longitudeAccuracy);
}
  
BOOL YKMKCoordinateRegionIsEqual(MKCoordinateRegion r1, MKCoordinateRegion r2, CLLocationDegrees accuracy) {
  return YKCLLocationCoordinate2DIsEqual(r1.center, r2.center, accuracy) && YKMKCoordinateSpanIsEqual(r1.span, r2.span, accuracy);  
}

BOOL YKMKCoordinateRegionIsSimilar(MKCoordinateRegion r1, MKCoordinateRegion r2, CLLocationDegrees centerAccuracy, double spanAccuracyPercentage) {
  return YKCLLocationCoordinate2DIsEqual(r1.center, r2.center, centerAccuracy) && YKMKCoordinateSpanIsSimilar(r1.span, r2.span, spanAccuracyPercentage);  
}

BOOL YKMKCoordinateSpanIsValid(MKCoordinateSpan span) {
  return (span.latitudeDelta > 0.0 && span.latitudeDelta < 180.0 && span.longitudeDelta > 0.0 && span.longitudeDelta < 360.0);
}

MKCoordinateSpan YKMKCoordinateSpanWithDefault(MKCoordinateSpan span, MKCoordinateSpan defaultSpan) {
  if (!YKMKCoordinateSpanIsValid(span)) return defaultSpan;
  return span;
}

MKCoordinateRegion YKMKCoordinateRegionWithDefault(CLLocationCoordinate2D coordinate, MKCoordinateSpan span, CLLocationCoordinate2D defaultCoordinate, MKCoordinateSpan defaultSpan) {
  if (!YKCLLocationCoordinate2DIsValid(coordinate)) coordinate = defaultCoordinate;
  if (!YKMKCoordinateSpanIsValid(span)) span = defaultSpan;
  
  return MKCoordinateRegionMake(coordinate, span);  
}

CLLocationDegrees YKMKCoordinateSpanMaxDelta(MKCoordinateSpan span1, MKCoordinateSpan span2, BOOL abs) {
  CLLocationDegrees latitudeDelta = span1.latitudeDelta - span2.latitudeDelta;
  CLLocationDegrees longitudeDelta = span1.longitudeDelta - span2.longitudeDelta;
  CLLocationDegrees maxDelta = (latitudeDelta > longitudeDelta ? latitudeDelta : longitudeDelta);
  if (abs) maxDelta = fabs(maxDelta);
  return maxDelta;
}

const MKCoordinateRegion YKMKCoordinateRegionNull = {{DBL_MAX, DBL_MAX}, {0, 0}};

extern BOOL YKMKCoordinateRegionIsNull(MKCoordinateRegion region) {
  return region.center.latitude == YKCLLocationCoordinate2DNull.latitude && region.center.longitude == YKCLLocationCoordinate2DNull.longitude;
}

MKCoordinateSpan YKMKCoordinateSpanDecode(id dict) {
  MKCoordinateSpan span;
  span.latitudeDelta = [dict gh_doubleForKey:@"latitudeDelta"];
  span.longitudeDelta = [dict gh_doubleForKey:@"longitudeDelta"];
  return span;
}

id YKMKCoordinateSpanEncode(MKCoordinateSpan span) {
  return [NSDictionary dictionaryWithObjectsAndKeys:
          [NSNumber numberWithDouble:span.latitudeDelta], @"latitudeDelta", 
          [NSNumber numberWithDouble:span.longitudeDelta], @"longitudeDelta", nil]; 
}

MKCoordinateRegion YKMKCoordinateRegionDecode(id dict) {
  if (dict == nil) return YKMKCoordinateRegionNull;
  CLLocationCoordinate2D center = YKCLLocationCoordinate2DDecode([dict gh_objectMaybeNilForKey:@"center"]);
  if (YKCLLocationCoordinate2DIsNull(center)) return YKMKCoordinateRegionNull;
  MKCoordinateSpan span = YKMKCoordinateSpanDecode([dict gh_objectMaybeNilForKey:@"span"]);
  return MKCoordinateRegionMake(center, span);
}

id YKMKCoordinateRegionEncode(MKCoordinateRegion region) {
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
          YKCLLocationCoordinate2DEncode(region.center), @"center", 
          YKMKCoordinateSpanEncode(region.span), @"span",
          nil];
  return dict;
}

CLLocationDistance YKMKCoordinateRegionLatitudinalMeters(MKCoordinateRegion region) {
  CLLocationDegrees latitudeStart = region.center.latitude - (region.span.latitudeDelta/2.0);
  CLLocationDegrees latitudeEnd = latitudeStart + region.span.latitudeDelta;
  CLLocationCoordinate2D coordinateStart = YKCLLocationCoordinate2DMake(latitudeStart, region.center.longitude);
  CLLocationCoordinate2D coordinateEnd = YKCLLocationCoordinate2DMake(latitudeEnd, region.center.longitude);
  return YKCLLocationCoordinateDistance(coordinateEnd, coordinateStart, YES);
}

CLLocationDistance YKMKCoordinateRegionLongitudinalMeters(MKCoordinateRegion region) {
  CLLocationDegrees longitudeStart = region.center.longitude - (region.span.longitudeDelta/2.0);
  CLLocationDegrees longitudeEnd = longitudeStart + region.span.longitudeDelta;
  CLLocationCoordinate2D coordinateStart = YKCLLocationCoordinate2DMake(region.center.latitude, longitudeStart);
  CLLocationCoordinate2D coordinateEnd = YKCLLocationCoordinate2DMake(region.center.latitude, longitudeEnd);
  return YKCLLocationCoordinateDistance(coordinateEnd, coordinateStart, YES);
}

NSValue *NSValueFromMKCoordinateRegion(MKCoordinateRegion region) {
  return [NSValue value:&region withObjCType:@encode(MKCoordinateRegion)];
}

MKCoordinateRegion MKCoordinateRegionFromNSValue(NSValue *value) {
  MKCoordinateRegion r;
  [value getValue:&r];
  return r;
}

MKCoordinateRegion MKCoordinateRegionScale(MKCoordinateRegion region, double scale) {
  region.span.latitudeDelta = region.span.latitudeDelta * scale;
  region.span.longitudeDelta = region.span.longitudeDelta * scale;
  return region;
}

BOOL YKCLLocationCoordinate2DIsInsideRegion(CLLocationCoordinate2D coordinate, MKCoordinateRegion region) {
  CLLocationDegrees minLatitude = region.center.latitude - (region.span.latitudeDelta / (double)2);
  CLLocationDegrees maxLatitude = region.center.latitude + (region.span.latitudeDelta / (double)2);
  CLLocationDegrees minLongitude = region.center.longitude - (region.span.longitudeDelta / (double)2);
  CLLocationDegrees maxLongitude = region.center.longitude + (region.span.longitudeDelta / (double)2);
  return (coordinate.latitude < maxLatitude && coordinate.latitude > minLatitude && coordinate.longitude < maxLongitude && coordinate.longitude > minLongitude);
}


@implementation YKMKUtils

+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations locationCoordinate:(CLLocationCoordinate2D)locationCoordinate {
  CLLocationDegrees minLatitude = 90;
  CLLocationDegrees maxLatitude = -90;
  CLLocationDegrees minLongitude = 180;
  CLLocationDegrees maxLongitude = -180;
  
  BOOL found = NO;
  CLLocationCoordinate2D center = YKCLLocationCoordinate2DNull;

  for (id annotation in annotations) {
    CLLocationCoordinate2D annotationCoordinate = [annotation coordinate];
    if (YKCLLocationCoordinate2DIsNull(annotationCoordinate)) continue;
    
    if (!YKCLLocationCoordinate2DIsNull(center) &&
        YKCLLocationCoordinateDistance(center, annotationCoordinate, YES) > kMaxRegionThatFitsRelativeCenterDistance) {
      continue;
    }
    
    if (annotationCoordinate.latitude < minLatitude) minLatitude = annotationCoordinate.latitude;
    if (annotationCoordinate.longitude < minLongitude) minLongitude = annotationCoordinate.longitude;
    if (annotationCoordinate.latitude > maxLatitude) maxLatitude = annotationCoordinate.latitude;
    if (annotationCoordinate.longitude > maxLongitude) maxLongitude = annotationCoordinate.longitude;
    
    center = YKCLLocationCoordinate2DMake((maxLatitude + minLatitude)/2.0, (maxLongitude + minLongitude)/2.0);
    found = YES;
  }
  
  BOOL useLocationCoordinate = !YKCLLocationCoordinate2DIsNull(locationCoordinate);
  CLLocationCoordinate2D coordinate;
  if (useLocationCoordinate) {
    // Use the current location, if available
    coordinate = locationCoordinate;
    // Check to make sure the current location is valid
    if (!YKCLLocationCoordinate2DIsNull(coordinate)) {
      if (found) {
        CLLocationDegrees centerLatitude = minLatitude + ((maxLatitude - minLatitude) / 2.0);
        CLLocationDegrees centerLongitude = minLongitude + ((maxLongitude - minLongitude) / 2.0);
        // Make sure the current location is somewhere near the annotations
        if (YKCLLocationCoordinateDistance(YKCLLocationCoordinate2DMake(centerLatitude, centerLongitude), coordinate, YES) < kMaxDistanceThatFitsRegion) {
          if (coordinate.latitude < minLatitude) minLatitude = coordinate.latitude;
          if (coordinate.longitude < minLongitude) minLongitude = coordinate.longitude;
          if (coordinate.latitude > maxLatitude) maxLatitude = coordinate.latitude;
          if (coordinate.longitude > maxLongitude) maxLongitude = coordinate.longitude;
        } else {
          // Don't use current location because it is too far away
          useLocationCoordinate = NO;
        }
      // If there is no location from annotations
      } else {
        if (coordinate.latitude < minLatitude) minLatitude = coordinate.latitude;
        if (coordinate.longitude < minLongitude) minLongitude = coordinate.longitude;
        if (coordinate.latitude > maxLatitude) maxLatitude = coordinate.latitude;
        if (coordinate.longitude > maxLongitude) maxLongitude = coordinate.longitude;
      }
    }
  }

  if (!found && (!useLocationCoordinate || YKCLLocationCoordinate2DIsNull(coordinate))) return YKMKCoordinateRegionNull;
    
  CLLocationDegrees centerLatitude = minLatitude + ((maxLatitude - minLatitude) / 2.0);
  CLLocationDegrees centerLongitude = minLongitude + ((maxLongitude - minLongitude) / 2.0);
  
  MKCoordinateSpan span = MKCoordinateSpanMake(maxLatitude - minLatitude, maxLongitude - minLongitude);
  // Ensure a minimum span in case there was only one point
  if (span.latitudeDelta < kMinLatitudeDelta || span.longitudeDelta < kMinLongitudeDelta) {
    span = kDefaultSpan;
  }

  return MKCoordinateRegionMake(YKCLLocationCoordinate2DMake(centerLatitude, centerLongitude), span);
}

+ (MKCoordinateRegion)regionForRegion:(MKCoordinateRegion)region insets:(CGPoint)insets size:(CGSize)size {
  if (YKMKCoordinateRegionIsNull(region)) return region;
  if (CGSizeEqualToSize(size, CGSizeZero) || YKCGPointIsEqual(insets, CGPointZero)) return region;

  double pixelsPerLongitude = region.span.longitudeDelta / (double)size.width;
  double pixelsPerLatitude = region.span.latitudeDelta / (double)size.height;
  
  double deltaY = (double)insets.y * pixelsPerLatitude;
  double deltaX = (double)insets.x * pixelsPerLongitude;

  region.span.latitudeDelta += deltaY;
  region.span.longitudeDelta += deltaX;
  return region;
}

+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations {
  return [self regionThatFits:annotations locationCoordinate:YKCLLocationCoordinate2DNull];
}

+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations center:(CLLocationCoordinate2D)center {
  CLLocationDegrees latitudeDelta = 0;
  CLLocationDegrees longitudeDelta = 0;
  for(id<MKAnnotation> annotation in annotations) {
    if (YKCLLocationCoordinate2DIsNull(annotation.coordinate)) continue;
    if (fabs(center.latitude - annotation.coordinate.latitude) > latitudeDelta) latitudeDelta = fabs(center.latitude - annotation.coordinate.latitude);
    if (fabs(center.longitude - annotation.coordinate.longitude) > longitudeDelta) longitudeDelta = fabs(center.longitude - annotation.coordinate.longitude);    
  }
  if (longitudeDelta < kMinLongitudeDelta && latitudeDelta < kMinLatitudeDelta)
    return MKCoordinateRegionMake(center, MKCoordinateSpanMake(kDefaultRegionSpanDelta, kDefaultRegionSpanDelta));  
  latitudeDelta = latitudeDelta * 2;
  longitudeDelta = longitudeDelta * 2;
  if (latitudeDelta > kMaxLatitudeDelta)
    latitudeDelta = kDefaultLatitudedDelta;
  if (longitudeDelta > kMaxLongitudeDelta)
    longitudeDelta = kDefaultLongitudeDelta;
  return MKCoordinateRegionMake(center, MKCoordinateSpanMake(latitudeDelta, longitudeDelta));
}

+ (MKCoordinateRegion)regionThatCentersOnAnnotation:(id<MKAnnotation>)annotation location:(CLLocation *)location {
  return [self regionThatCentersOnAnnotation:annotation location:location maxDistance:kMaxDistanceThatFitsRegion coordinateSpan:kDefaultSpan];
}

+ (MKCoordinateRegion)regionThatCentersOnAnnotation:(id<MKAnnotation>)annotation location:(CLLocation *)location maxDistance:(CLLocationDistance)maxDistance coordinateSpan:(MKCoordinateSpan)coordinateSpan {
  if (location) {
    if (YKCLLocationCoordinate2DIsNull(location.coordinate) || (YKCLLocationCoordinateDistance(annotation.coordinate, location.coordinate, YES) > maxDistance))
      return MKCoordinateRegionMake(annotation.coordinate, coordinateSpan);
    else
      return [self regionThatFits:[NSArray arrayWithObjects:annotation, [self annotationFromCLLocation:location title:NSLocalizedString(@"Current Location", nil)], nil] center:annotation.coordinate];  
  } else {
    return MKCoordinateRegionMake(annotation.coordinate, coordinateSpan);
  }
}
  
+ (id<MKAnnotation>)annotationFromCLLocation:(CLLocation *)location title:(NSString *)title {
  YKMKAnnotation *annotation = [[YKMKAnnotation alloc] init];   
  annotation.coordinate = location.coordinate;
  annotation.title = title;
  return [annotation autorelease];
}

+ (MKCoordinateRegion)regionFromJSON:(NSDictionary *)JSONDict {
  MKCoordinateRegion region = YKMKCoordinateRegionNull;
  NSDictionary *centerDict = [JSONDict gh_objectMaybeNilForKey:@"center"];
  NSDictionary *spanDict = [JSONDict gh_objectMaybeNilForKey:@"span"];
  if (centerDict && spanDict) {
    region = MKCoordinateRegionMake(YKCLLocationCoordinate2DMake([centerDict gh_doubleForKey:@"latitude"], [centerDict gh_doubleForKey:@"longitude"]), 
                                    MKCoordinateSpanMake([spanDict gh_doubleForKey:@"latitude_delta"], [spanDict gh_doubleForKey:@"longitude_delta"]));
  }
  return region;
}

@end
