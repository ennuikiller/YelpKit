//
//  YKUIBorderView.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/25/12.
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

#import "YKUIBorderView.h"
#import "YKUIBorder.h"
#import "YKCGUtils.h"

@implementation YKUIBorderView

- (id)initWithView:(UIView *)view {
  if ((self = [super init])) {
    _view = view;
    [self addSubview:_view];

    _border = [[YKUIBorder alloc] initWithFrame:CGRectZero style:YKUIBorderStyleRounded];
    
    _border.color = [UIColor colorWithWhite:0.7 alpha:1.0];
    [self addSubview:_border];
    [_border release];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
  _border.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
  
  CGRect maskRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

  if (_border.cornerRadius > 0) {
    UIImage *mask = YKCGContextRoundedMask(maskRect, _border.cornerRadius);
    CALayer *layerMask = [CALayer layer];
    layerMask.frame = maskRect;       
    layerMask.contents = (id)mask.CGImage;   
    _view.layer.mask = layerMask;
  } else {
    _view.layer.mask = NULL;
  }
}

// Not sure why we have to do this
- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [_border setNeedsDisplay];
  [self setNeedsLayout];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  _border.cornerRadius = cornerRadius;
  [_border setNeedsDisplay];
}

- (CGFloat)cornerRadius {
  return _border.cornerRadius;
}

- (UIColor *)shadowColor {
  return _border.shadowColor;
}

- (void)setShadowColor:(UIColor *)shadowColor {
  _border.shadowColor = shadowColor;
  [_border setNeedsDisplay];
}

- (UIColor *)borderColor {
  return _border.shadowColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
  _border.color = borderColor;
  [_border setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
  _border.fillColor = fillColor;
  [_border setNeedsDisplay];
}

- (UIColor *)fillColor {
  return _border.fillColor;
}

@end
