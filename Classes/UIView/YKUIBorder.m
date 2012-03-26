//
//  YKUIBorder.m
//  YelpKit
//
//  Created by Gabriel Handford on 12/29/08.
//  Copyright 2008 Yelp. All rights reserved.
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

#import "YKUIBorder.h"
#import "YKCGUtils.h"

@implementation YKUIBorder

@synthesize contentView=_contentView, cornerRadius=_cornerRadius, color=_color, strokeWidth=_strokeWidth, alternateStrokeWidth=_alternateStrokeWidth, fillColor=_fillColor, highlightedColor=_highlightedColor, highlighted=_highlighted, style=_style, shadowColor=_shadowColor, shadowBlur=_shadowBlur, clippingInset=_clippingInset, shadingType=_shadingType, shadingColor=_shadingColor, shadingAlternateColor=_shadingAlternateColor;

- (void)sharedInit {
  self.opaque = NO;
  _cornerRadius = 10.0;
  _alternateStrokeWidth = 0.5;
  _shadingType = YKUIShadingTypeNone;
  _shadowBlur = 3.0;
  _clippingInset = 0;
  self.userInteractionEnabled = NO;
}

- (id)initWithCoder:(NSCoder *)coder {
  if ((self = [super initWithCoder:coder])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame style:(YKUIBorderStyle)style stroke:(CGFloat)stroke color:(UIColor *)color {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
    _color = [color retain];
    _strokeWidth = stroke;
    _alternateStrokeWidth = stroke;
    _style = style;
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame style:(YKUIBorderStyle)style {
  return [self initWithFrame:frame style:style stroke:0.5 color:[UIColor grayColor]];
}

- (id)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame style:YKUIBorderStyleRounded];
}

- (void)dealloc {
  [_color release];
  [_highlightedColor release];
  [_fillColor release];
  [_shadingColor release];
  [_shadingAlternateColor release];
  [_shadowColor release];
  [super dealloc];
}

- (void)setHighlighted:(BOOL)highlighted {
  _highlighted = highlighted;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext(); 
  
  if (_shadingType != YKUIShadingTypeNone) {
    YKCGContextDrawShadingWithHeight(context, _shadingColor.CGColor, _shadingAlternateColor.CGColor, NULL, NULL, self.bounds.size.height, _shadingType);
  }
  
  if (_shadowColor) {
    CGPathRef path = YKCGPathCreateStyledRect(CGRectInset(self.bounds, _clippingInset, _clippingInset), _style, _strokeWidth, _alternateStrokeWidth, _cornerRadius);
    CGContextAddPath(context, path);
    CGContextClip(context);
    YKCGContextDrawBorderWithShadow(context, self.bounds, _style, (self.highlighted ? _highlightedColor.CGColor : _fillColor.CGColor), _color.CGColor, _strokeWidth, _alternateStrokeWidth, _cornerRadius, _shadowColor.CGColor, _shadowBlur);
    CGPathRelease(path);
  } else {
    YKCGContextDrawBorder(context, self.bounds, _style, (self.highlighted ? _highlightedColor.CGColor : _fillColor.CGColor), _color.CGColor, _strokeWidth, _alternateStrokeWidth, _cornerRadius);
  }
}

@end
