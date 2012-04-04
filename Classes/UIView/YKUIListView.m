//
//  YKUIListView.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/24/12.
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

#import "YKUIListView.h"
#import "YKCGUtils.h"

@implementation YKUIListView

@synthesize appearance=_appearance;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.layout = [YKLayout layoutForView:self];
    self.backgroundColor = [UIColor whiteColor];
    _insets = UIEdgeInsetsMake(0, 0, 0, 0);
    _appearance = [[YKUIListViewAppearance alloc] init];
    _appearance.userInteractionEnabled = NO;
    [self addSubview:_appearance];
    [_appearance release];
  }
  return self;
}

- (void)dealloc {
  [_views release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat x = _insets.left;
  CGFloat y = _insets.top;
  for (UIView *view in _views) {
    CGRect viewRect = [layout setFrame:CGRectMake(x, y, size.width - x - _insets.right, 0) view:view sizeToFit:YES];
    y += viewRect.size.height;
  }
  y += _insets.bottom;
  [layout setFrame:CGRectMake(0, 0, size.width, y) view:_appearance];
  [_appearance setNeedsDisplay];
  return CGSizeMake(size.width, y);
}

- (NSArray *)views {
  return _views;
}

- (NSInteger)count {
  return [_views count];
}

- (void)addView:(UIView *)view {
  if (!_views) _views = [[NSMutableArray alloc] init];
  [_views addObject:view];
  [self addSubview:view];
  
  [self bringSubviewToFront:_appearance];
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

- (void)removeViewsWithTag:(NSInteger)tag {
  NSMutableArray *views = [[NSMutableArray alloc] init];
  for (UIView *view in _views) {
    if (view.tag == tag) {
      [views addObject:view];
      [view removeFromSuperview];
    }
  }
  [_views removeObjectsInArray:views];
  [views release];
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

@end


@implementation YKUIListViewAppearance 

@synthesize lineSeparatorColor=_lineSeparatorColor, topBorderColor=_topBorderColor;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    _insets = UIEdgeInsetsMake(0, 10, 0, 10);
  }
  return self;
}

- (void)dealloc {
  [_lineSeparatorColor release];
  [_topBorderColor release];
  [super dealloc];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  CGContextRef context = UIGraphicsGetCurrentContext();
  if (_topBorderColor) {
    YKCGContextDrawLine(context, _insets.left, 0.5 + _insets.top, self.frame.size.width - _insets.right, 0.5 + _insets.top, _topBorderColor.CGColor, 0.5);
  }

  if (_lineSeparatorColor) {
    CGFloat y = 0;
    NSInteger index = 0;
    NSArray *views = [(YKUIListView *)[self superview] views];
    for (UIView *view in views) {
      y += view.frame.size.height;
      if (index++ != [views count] - 1) {
        YKCGContextDrawLine(context, _insets.left, y - 0.5 + _insets.bottom, self.frame.size.width - _insets.right, y - 0.5 + _insets.bottom, _lineSeparatorColor.CGColor, 0.5);
      }
    }
  }
}

@end