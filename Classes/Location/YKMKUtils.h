//
//  YKMKUtils.h
//  YelpKit
//
//  Created by Gabriel Handford on 6/12/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "YKCLUtils.h"


#define kDefaultLatitudedDelta .005
#define kDefaultLongitudeDelta .005
#define kDefaultSpan MKCoordinateSpanMake(kDefaultLatitudedDelta, kDefaultLongitudeDelta)

NSString *YKNSStringFromMKCoordinateSpan(MKCoordinateSpan span);

NSString *YKNSStringFromMKCoordinateRegion(MKCoordinateRegion region);

extern BOOL YKMKCoordinateSpanIsEqual(MKCoordinateSpan s1, MKCoordinateSpan s2, CLLocationDegrees accuracy);
extern BOOL YKMKCoordinateRegionIsEqual(MKCoordinateRegion r1, MKCoordinateRegion r2, CLLocationDegrees accuracy);

extern BOOL YKMKCoordinateSpanIsSimilar(MKCoordinateSpan s1, MKCoordinateSpan s2, double spanAccuracyPercentage);
extern BOOL YKMKCoordinateRegionIsSimilar(MKCoordinateRegion r1, MKCoordinateRegion r2, CLLocationDegrees centerAccuracy, double spanAccuracyPercentage);

extern const MKCoordinateRegion YKMKCoordinateRegionNull;

extern BOOL YKMKCoordinateRegionIsNull(MKCoordinateRegion region);

MKCoordinateRegion YKMKCoordinateRegionWithDefault(CLLocationCoordinate2D coordinate, MKCoordinateSpan span, CLLocationCoordinate2D defaultCoordinate, MKCoordinateSpan defaultSpan);

BOOL YKMKCoordinateSpanIsValid(MKCoordinateSpan span);  

MKCoordinateSpan YKMKCoordinateSpanWithDefault(MKCoordinateSpan span, MKCoordinateSpan defaultSpan);

CLLocationDegrees YKMKCoordinateSpanMaxDelta(MKCoordinateSpan span1, MKCoordinateSpan span2, BOOL abs);

MKCoordinateSpan YKMKCoordinateSpanDecode(id dict);

id YKMKCoordinateSpanEncode(MKCoordinateSpan span);

MKCoordinateRegion YKMKCoordinateRegionDecode(id dict);

id YKMKCoordinateRegionEncode(MKCoordinateRegion region);

NSValue *NSValueFromMKCoordinateRegion(MKCoordinateRegion region);

MKCoordinateRegion MKCoordinateRegionFromNSValue(NSValue *value); 

MKCoordinateRegion MKCoordinateRegionScale(MKCoordinateRegion region, double scale);

BOOL YKCLLocationCoordinate2DIsInsideRegion(CLLocationCoordinate2D coordinate, MKCoordinateRegion region);

/*!
 Distance of the region latitude delta, based on YKCLLocationDistance (Haversine)
 */
CLLocationDistance YKMKCoordinateRegionLatitudinalMeters(MKCoordinateRegion region);

/*!
 Distance of the region longitude delta, based on YKCLLocationDistance (Haversine)
 */
CLLocationDistance YKMKCoordinateRegionLongitudinalMeters(MKCoordinateRegion region);

MKCoordinateRegion YKMKCoordinateRegionInset(MKCoordinateRegion region, CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta);

@interface YKMKUtils : NSObject {}

/*!
 Region that fits annotations.
 @param annotations Annotations, id<MKAnnotation> or any object that responds to - (CLLocationCoordinate2D)coordinate
 @param useCurrentLocation If YES, will use currentLocationCoordinate
 @param currentLocationCoordinate Coordinate to include
 */
+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations useCurrentLocation:(BOOL)useCurrentLocation currentLocationCoordinate:(CLLocationCoordinate2D)currentLocationCoordinate;

/*!
 Region that fits annotations.
 @param annotations Annotations, id<MKAnnotation> or any object that responds to - (CLLocationCoordinate2D)coordinate
 */
+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations;

/*!
 Region that fits annotations.
 @param annotations Annotations, id<MKAnnotation> or any object that responds to - (CLLocationCoordinate2D)coordinate
 @param center Center point
 */
+ (MKCoordinateRegion)regionThatFits:(NSArray *)annotations center:(CLLocationCoordinate2D)center;

// NOTE: This function centers on the annotation but includes the current location
+ (MKCoordinateRegion)regionThatCentersOnAnnotation:(id<MKAnnotation>)annotation location:(CLLocation *)location;

+ (id<MKAnnotation>)annotationFromCLLocation:(CLLocation *)location title:(NSString *)title;

+ (MKCoordinateRegion)regionFromJSON:(NSDictionary *)jsonDict;

@end
