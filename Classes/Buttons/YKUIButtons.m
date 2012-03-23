//
//  YKUIButtons.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/22/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUIButtons.h"
#import "YKUIButton.h"
#import "YKUIButtonStyles.h"

@implementation YKUIButtons

- (id)initWithCount:(NSInteger)count apply:(YKUIButtonsApplyBlock)apply {
  if ((self = [super init])) {
    _buttons = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
      YKUIButton *button = [[YKUIButton alloc] init];
      
      if (count == 1) {
        button.borderStyle = YKUIBorderStyleRounded;
      } else {
        if (i == 0) {
          button.borderStyle = YKUIBorderStyleRoundedLeftCap;
        } else if (i == count - 1) {
          button.borderStyle = YKUIBorderStyleRoundedRightCap;
        } else {
          button.borderStyle = YKUIBorderStyleNormal;
        }
      }
      
      apply(button, i);

      [_buttons addObject:button];
      [self addSubview:button];
      [button release];
    }
  }
  return self;
}

- (void)dealloc {
  [_buttons release];
  [super dealloc];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat x = 0;
  CGFloat buttonWidth = roundf(self.frame.size.width / (CGFloat)[_buttons count]);
  NSInteger i = 0;
  for (YKUIButton *button in _buttons) {
    CGFloat padding = (i == [_buttons count] - 1 ? 0 : 2);
    button.frame = CGRectMake(x, 0, buttonWidth + padding, self.frame.size.height);
    x += buttonWidth; // Have the left border overlap the previous right border
    i++;
  }
}

- (NSArray *)buttons {
  return _buttons;
}

@end
