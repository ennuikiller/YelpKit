//
//  YKUIListView.h
//  YelpKit
//
//  Created by Gabriel Handford on 3/24/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKUILayoutView.h"

@class YKUIListViewAppearance;

@interface YKUIListView : YKUILayoutView {
  NSMutableArray *_views;
  
  YKUIListViewAppearance *_appearance;
}

@property (retain, nonatomic) YKUIListViewAppearance *appearance;

- (NSArray *)views;

- (NSInteger)count;

- (void)addView:(UIView *)view;

@end


@interface YKUIListViewAppearance : UIView {
  UIColor *_lineSeparatorColor;
  UIColor *_topBorderColor;
}

@property (retain, nonatomic) UIColor *topBorderColor;
@property (retain, nonatomic) UIColor *lineSeparatorColor;

@end
