//
//  YKUIImageControl.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/29/12.
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

#import "YKUIImageControl.h"
#import "YKUIImageView.h"

@implementation YKUIImageControl

@synthesize view=_view, highlightedColor=_highlightedColor;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.highlightedEnabled = YES;
    [self setView:[[[YKUIImageView alloc] init] autorelease]];
  }
  return self;
}

- (void)dealloc {
  [_view cancel];
  [_view release];
  [_highlightedColor release];
  [super dealloc];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _view.frame = self.bounds;
}

- (void)setView:(YKUIImageView *)view {
  [view retain];
  [_view removeFromSuperview];
  [_view release];
  _view = view;
  [self addSubview:_view];
  _view.userInteractionEnabled = NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  [_view setBackgroundColor:backgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (!_highlightedColor) return;
  if (highlighted) {
    [_view setOverlayColor:_highlightedColor];
  } else {
    [_view setOverlayColor:nil];
  }
  [_view setNeedsDisplay];
}

- (void)setURLString:(NSString *)URLString { 
  [_view setURLString:URLString];
}

- (NSString *)URLString {
  return [_view URLString];
}

- (void)setImage:(UIImage *)image { 
  [_view setImage:image];
  [_view setNeedsDisplay];
}

- (UIImage *)image { 
  return [_view image];
}

- (void)cancel {
  [_view cancel];
}

@end
