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

- (id)initWithCount:(NSInteger)count style:(YKUIButtonsStyle)style apply:(YKUIButtonsApplyBlock)apply {
  NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:count];
  for (NSInteger i = 0; i < count; i++) {
    [buttons addObject:[[[YKUIButton alloc] init] autorelease]];
  }
  return [self initWithButtons:buttons style:style apply:apply];
}

- (id)initWithButtons:(NSArray *)buttons style:(YKUIButtonsStyle)style apply:(YKUIButtonsApplyBlock)apply {
  if ((self = [super init])) {
    self.backgroundColor = [UIColor clearColor];
    self.layout = [YKLayout layoutForView:self];

    _style = style;
    _buttons = [buttons mutableCopy];
    for (NSInteger i = 0, count = [_buttons count]; i < count; i++) {
      YKUIButton *button = [_buttons objectAtIndex:i];

      if (count == 1) {
        button.borderStyle = YKUIBorderStyleRounded;
      } else {
        if (i == 0) {
          switch (style) {
            case YKUIButtonsStyleHorizontal:
              button.borderStyle = YKUIBorderStyleRoundedLeftCap;
              break;
            case YKUIButtonsStyleVertical:
              button.borderStyle = YKUIBorderStyleRoundedTop;
              break;
          }
        } else if (i == count - 1) {
          switch (style) {
            case YKUIButtonsStyleHorizontal:
              button.borderStyle = YKUIBorderStyleRoundedRightCap;
              break;
            case YKUIButtonsStyleVertical:
              button.borderStyle = YKUIBorderStyleRoundedBottomWithAlternateTop;
              break;
          }
        } else {
          button.borderStyle = YKUIBorderStyleNormal;
        }
      }
      
      apply(button, i);

      [self addSubview:button];
    }
  }
  return self;
}

- (void)dealloc {
  [_buttons release];
  [super dealloc];
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat y = 0;

  switch (_style) {
    case YKUIButtonsStyleHorizontal: {
      CGFloat x = 0;
      CGFloat buttonWidth = roundf(size.width / (CGFloat)[_buttons count]);
      NSInteger i = 0;
      for (YKUIButton *button in _buttons) {
        CGFloat padding = (i == [_buttons count] - 1 ? 0 : 2);
        button.frame = CGRectMake(x, 0, buttonWidth + padding, size.height);
        x += buttonWidth; // Have the left border overlap the previous right border
        i++;
      }
      y = size.height;
      break;
    }
    case YKUIButtonsStyleVertical: {
      for (YKUIButton *button in _buttons) {
        button.frame = CGRectMake(0, y, size.width, button.frame.size.height);
        y += button.frame.size.height;
      }
      break;
    }
  }
  
  return CGSizeMake(size.width, y);
}

- (NSArray *)buttons {
  return _buttons;
}

@end
