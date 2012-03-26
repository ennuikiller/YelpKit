//
//  YKUIButtons.h
//  YelpKit
//
//  Created by Gabriel Handford on 3/22/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"
@class YKUIButton;

typedef enum {
  YKUIButtonsStyleHorizontal = 0, // Default
  YKUIButtonsStyleVertical,
} YKUIButtonsStyle;

typedef void (^YKUIButtonsApplyBlock)(YKUIButton *button, NSInteger index);

@interface YKUIButtons : YKUILayoutView {
  NSMutableArray *_buttons;
  
  YKUIButtonsStyle _style;
}

- (id)initWithCount:(NSInteger)count style:(YKUIButtonsStyle)style apply:(YKUIButtonsApplyBlock)apply;

- (id)initWithButtons:(NSArray *)buttons style:(YKUIButtonsStyle)style apply:(YKUIButtonsApplyBlock)apply;

- (NSArray *)buttons;

@end
