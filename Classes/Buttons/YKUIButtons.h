//
//  YKUIButtons.h
//  YelpKit
//
//  Created by Gabriel Handford on 3/22/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

@class YKUIButton;

typedef void (^YKUIButtonsApplyBlock)(YKUIButton *button, NSInteger index);

@interface YKUIButtons : UIView {
  NSMutableArray *_buttons;
}

- (id)initWithCount:(NSInteger)count apply:(YKUIButtonsApplyBlock)apply;

- (NSArray *)buttons;

@end
