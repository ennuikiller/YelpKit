//
//  YKUIButtons.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/22/12.
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
    self.backgroundColor = [UIColor whiteColor];
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
          switch (style) {
            case YKUIButtonsStyleHorizontal:
              button.borderStyle = YKUIBorderStyleNormal;
              break;
            case YKUIButtonsStyleVertical:
              button.borderStyle = YKUIBorderStyleLeftRightWithAlternateTop;
              break;
          }          
        }
      }
      
      if (apply != NULL) {
        apply(button, i);
      }

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
        CGFloat padding = (i == [_buttons count] - 1 ? 0 : 1);
        [layout setFrame:CGRectMake(x, 0, buttonWidth + padding, size.height) view:button];
        x += buttonWidth;
        i++;
      }
      y = size.height;
      break;
    }
    case YKUIButtonsStyleVertical: {
      for (YKUIButton *button in _buttons) {
        CGRect buttonFrame = [layout setFrame:CGRectMake(0, y, size.width, button.frame.size.height) view:button sizeToFit:YES];
        y += buttonFrame.size.height;
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
