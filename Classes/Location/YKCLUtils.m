//
//  YKCLUtils.m
//  YelpKit
//
//  Created by Gabriel Handford on 1/29/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "YKCLUtils.h"

CLLocationDistance YKCLLocationCoordinateDistance(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2, BOOL absolute) {    
  double radius = 6371; // Earth’s radius in Kilometers
  double latitudeDiff = YK_DEGREES_TO_RADIANS(c2.latitude - c1.latitude);  
  double longitudeDiff = YK_DEGREES_TO_RADIANS(c2.longitude - c1.longitude);
  double nA = pow(sin(latitudeDiff/2), 2) + cos(YK_DEGREES_TO_RADIANS(c1.latitude)) * cos(YK_DEGREES_TO_RADIANS(c2.latitude)) * pow(sin(longitudeDiff/2), 2);
  double nC = 2 * atan2(sqrt(nA), sqrt(1 - nA));
  CLLocationDistance distance = (radius * nC) * 1000; // Convert from kilometers to meters
  if (absolute && distance < 0) distance *= -1;
  return distance;
}

double YKCLLocationCoordinateBearing(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2) {
  double longitudeDiff = YK_DEGREES_TO_RADIANS(c2.longitude) - YK_DEGREES_TO_RADIANS(c1.longitude);  
  
  double latitude1Radians = YK_DEGREES_TO_RADIANS(c1.latitude);
  double latitude2Radians = YK_DEGREES_TO_RADIANS(c2.latitude);
  double bearingRadians = atan2(sin(longitudeDiff) * cos(latitude2Radians),
                                cos(latitude1Radians) * sin(latitude2Radians)
                                - sin(latitude1Radians) * cos(latitude2Radians) * cos(longitudeDiff));
  
  double bearingDegrees = YK_RADIANS_TO_DEGREES(bearingRadians);
  return fmod((bearingDegrees + 360.0), 360);
}

// Represents NULL CLLocationCoordinate2D
const CLLocationDegrees YKCLLatitudeNull = DBL_MAX;
const CLLocationDegrees YKCLLongitudeNull = DBL_MAX;
const CLLocationCoordinate2D YKCLLocationCoordinate2DNull = {DBL_MAX, DBL_MAX}; // {YKCLLatitudeNull, YKCLLongitudeNull}

CLLocationCoordinate2D YKCLLocationCoordinate2DDecode(id obj) {
  CLLocationCoordinate2D locationCoordinate = YKCLLocationCoordinate2DNull;
  id latitude = [obj valueForKey:@"latitude"];
  id longitude = [obj valueForKey:@"longitude"];
  if (latitude && longitude && ![[NSNull null] isEqual:latitude] && ![[NSNull null] isEqual:longitude]) {
    locationCoordinate.latitude = [latitude doubleValue];
    locationCoordinate.longitude = [longitude doubleValue];
  }
  return locationCoordinate;
}

id YKCLLocationCoordinate2DEncode(CLLocationCoordinate2D coordinate) {
  return [NSDictionary dictionaryWithObjectsAndKeys:
          [NSNumber numberWithDouble:coordinate.latitude], @"latitude", 
          [NSNumber numberWithDouble:coordinate.longitude], @"longitude", nil];
}
  
BOOL YKCLLocationCoordinate2DIsValid(CLLocationCoordinate2D coordinate) {
  return (coordinate.latitude >= -90.0 && coordinate.latitude <= 90.0 && coordinate.longitude >= -180.0 && coordinate.longitude <= 180.0);
}

BOOL YKCenterRadiusContainsCoordinate(CLLocationCoordinate2D center, CLLocationDistance radius, CLLocationCoordinate2D coordinate) {
  return (radius >= YKCLLocationCoordinateDistance(center, coordinate, YES));
}

NSString *YKNSStringFromCLLocationCoordinate2D(CLLocationCoordinate2D coordinate) {
  return [NSString stringWithFormat:@"(%0.6f, %0.6f)", coordinate.latitude, coordinate.longitude];
}

BOOL YKCLLocationCoordinateIsEqual(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2) {
  return YKCLLocationCoordinateIsEqualWithAccuracy(c1, c2, 0.0000001);
}

BOOL YKCLLocationCoordinateIsEqualWithAccuracy(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2, double accuracy) {
  return (YKIsEqualWithAccuracy(c1.latitude, c2.latitude, accuracy) &&
          YKIsEqualWithAccuracy(c1.longitude, c2.longitude, accuracy));
}

NSValue *NSValueFromCLLocationCoordinate2D(CLLocationCoordinate2D coordinate) {
  return [NSValue value:&coordinate withObjCType:@encode(CLLocationCoordinate2D)];
}

CLLocationCoordinate2D YKCLLocationCoordinate2DFromNSValue(NSValue *value) {
  CLLocationCoordinate2D c;
  [value getValue:&c];
  return c;
}

CLLocationCoordinate2D YKCLLocationCoordinateMoveDistance(CLLocationCoordinate2D coordinate, CLLocationDistance distance, double bearingInRadians) {
	double lat1 = YK_DEGREES_TO_RADIANS(coordinate.latitude);
	double lon1 = YK_DEGREES_TO_RADIANS(coordinate.longitude);
	
	double a = 6378137, b = 6356752.3142, f = 1/298.257223563;  // WGS-84 ellipsiod
	double s = distance;
	double alpha1 = bearingInRadians;
	double sinAlpha1 = sin(alpha1);
	double cosAlpha1 = cos(alpha1);
	
	double tanU1 = (1 - f) * tan(lat1);
	double cosU1 = 1 / sqrt((1 + tanU1 * tanU1));
	double sinU1 = tanU1 * cosU1;
	double sigma1 = atan2(tanU1, cosAlpha1);
	double sinAlpha = cosU1 * sinAlpha1;
	double cosSqAlpha = 1 - sinAlpha * sinAlpha;
	double uSq = cosSqAlpha * (a * a - b * b) / (b * b);
	double A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
	double B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
	
	double sigma = s / (b * A);
	double sigmaP = 2 * M_PI;
	
	double cos2SigmaM = 0, sinSigma = 0, cosSigma = 0;
	
	while(abs(sigma - sigmaP) > 1e-12) {
		cos2SigmaM = cos(2 * sigma1 + sigma);
		sinSigma = sin(sigma);
		cosSigma = cos(sigma);
		double deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
		sigmaP = sigma;
		sigma = s / (b * A) + deltaSigma;
	}
	
	double tmp = (sinU1 * sinSigma) - (cosU1 * cosSigma * cosAlpha1);
	double lat2 = atan2(sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1, (1 - f) * sqrt(sinAlpha * sinAlpha + tmp * tmp));
	double lambda = atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1);
	double C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
	double L = lambda - (1 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
	
	double lon2 = lon1 + L;
	
	CLLocationCoordinate2D dest;
	dest.latitude = YK_RADIANS_TO_DEGREES(lat2);
	dest.longitude = YK_RADIANS_TO_DEGREES(lon2);
	return dest;
}
