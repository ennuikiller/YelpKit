//
//  YKUIListView.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/24/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUIListView.h"
#import "YKCGUtils.h"

@implementation YKUIListView

@synthesize appearance=_appearance;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.layout = [YKLayout layoutForView:self];
    self.backgroundColor = [UIColor whiteColor];
    _appearance = [[YKUIListViewAppearance alloc] init];
    _appearance.userInteractionEnabled = NO;
    [self addSubview:_appearance];
  }
  return self;
}

- (void)dealloc {
  [_views release];
  [_appearance release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat x = 0;
  CGFloat y = 0;
  for (UIView *view in _views) {
    CGRect viewRect = [layout setFrame:CGRectMake(x, y, size.width, 0) view:view sizeToFit:YES];
    y += viewRect.size.height;
  }
  [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:_appearance];
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
  [self sendSubviewToBack:view];
  [self setNeedsLayout];
  [_appearance setNeedsDisplay];
}

@end


@implementation YKUIListViewAppearance 

@synthesize lineSeparatorColor=_lineSeparatorColor, topBorderColor=_topBorderColor;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.backgroundColor = [UIColor clearColor];
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
    YKCGContextDrawLine(context, 0, 0.5, self.frame.size.width, 0.5, _topBorderColor.CGColor, 0.5);
  }

  if (_lineSeparatorColor) {
    CGFloat y = 0;
    NSInteger index = 0;
    NSArray *views = [(YKUIListView *)[self superview] views];
    for (UIView *view in views) {
      y += view.frame.size.height;
      if (index++ != [views count] - 1) {
        YKCGContextDrawLine(context, 0, y - 0.5, self.frame.size.width, y - 0.5, _lineSeparatorColor.CGColor, 0.5);
      }
    }
  }
}

@end