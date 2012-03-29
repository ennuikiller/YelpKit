//
//  YKUISwipeView.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/26/12.
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

#import "YKUISwipeView.h"

@implementation YKUISwipeView

@synthesize peekWidth=_peekWidth, insets=_insets, scrollView=_scrollView, views=_views;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.userInteractionEnabled = NO;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.directionalLockEnabled = YES;
    [self addSubview:_scrollView];
    [_scrollView release];
    
    _peekWidth = 40;
    _insets = UIEdgeInsetsMake(0, 10, 0, 10);
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  // Disable swipe when we only have 1 view.
  // Otherwise setup the peek.
  if ([_views count] == 1) {
    UIView *view = [_views objectAtIndex:0];
    view.frame = CGRectMake(_insets.left, _insets.top, self.frame.size.width - _insets.left - _insets.right, self.frame.size.height - _insets.top - _insets.bottom);
    _scrollView.alwaysBounceHorizontal = NO;    
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
  } else {
    CGFloat x = _insets.left;
    NSInteger i = 0;
    for (UIView *view in _views) {
      BOOL lastView = (++i == [_views count]);
      CGFloat width = self.frame.size.width - _peekWidth;
      
      view.frame = CGRectMake(x, _insets.top, width, self.frame.size.height - _insets.top - _insets.bottom);
      x += width;
      
      if (!lastView) {
        x += _insets.right;
      }
    }

    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width - _peekWidth + _insets.right, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(x, self.frame.size.height);
  }
}

- (UIView *)hitTest:(CGPoint) point withEvent:(UIEvent *)event {
  if ([self pointInside:point withEvent:event]) {
    return [_scrollView hitTest:[_scrollView convertPoint:point fromView:self] withEvent:event];
  }
  return nil;
}

- (void)setViews:(NSArray *)views {
  [views retain];
  for (UIView *view in _views) {
    [view removeFromSuperview];
  }
  [_views release];
  _views = views;
  
  for (UIView *view in _views) {
    [_scrollView addSubview:view];
  }
  [self setNeedsDisplay];
  [self setNeedsLayout];
}

@end
