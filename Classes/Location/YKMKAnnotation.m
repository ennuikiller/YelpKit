//
//  YKMKAnnotation.m
//  YelpIPhone
//
//  Created by Gabriel Handford on 10/14/10.
//  Copyright 2010 Yelp. All rights reserved.
//

#import "YKMKAnnotation.h"

@implementation YKMKAnnotation

@synthesize coordinate=_coordinate, title=_title, subtitle=_subtitle, draggable=_draggable, selected=_selected, enabled=_enabled, canShowCallout=_canShowCallout, animatesDrop=_animatesDrop, color=_color, leftCalloutAccessoryView=_leftCalloutAccessoryView, index=_index;

- (id)init {
  if ((self = [super init])) {
    _enabled = YES;
    _color = MKPinAnnotationColorRed;
  }
  return self;
}

+ (YKMKAnnotation *)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle 
                             leftCalloutAccessoryView:(UIView *)leftCalloutAccessoryView draggable:(BOOL)draggable {
  
  YKMKAnnotation *annotation = [[YKMKAnnotation alloc] init];
  annotation.coordinate = coordinate;
  annotation.title = title;
  annotation.subtitle = subtitle;
  annotation.draggable = draggable;
  if (title)
    annotation.canShowCallout = YES;
  annotation.leftCalloutAccessoryView = leftCalloutAccessoryView;
  return [annotation autorelease];
}

- (void)dealloc {
  [_title release];
  [_subtitle release];
  [_leftCalloutAccessoryView release];
  [super dealloc];
}

- (NSString *)viewReuseIdentifier {
  return @"YKMKAnnotation";
}

- (UIImage *)annotationImageForSelected:(BOOL)selected {
  return nil;
}

- (id<YKMKAnnotation>)annotationForCallout {
  return self;
}

- (MKAnnotationView<YKMKAnnotationView> *)view {
  MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:[self viewReuseIdentifier]];
  
  // Draggable only available in iOS4
  if ([pinAnnotationView respondsToSelector:@selector(setDraggable:)])
    [pinAnnotationView setDraggable:self.isDraggable];

  pinAnnotationView.enabled = _enabled;
  pinAnnotationView.canShowCallout = _canShowCallout;
  pinAnnotationView.animatesDrop = _animatesDrop;
  pinAnnotationView.pinColor = _color;  
  pinAnnotationView.leftCalloutAccessoryView = _leftCalloutAccessoryView; 
  return (id)[pinAnnotationView autorelease];
}

@end
