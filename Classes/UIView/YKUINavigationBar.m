//
//  YKUINavigationBar.m
//  YelpKit
//
//  Created by Gabriel Handford on 3/31/12.
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

#import "YKUINavigationBar.h"
#import "YKCGUtils.h"
#import "YKUIButton.h"

@implementation YKUINavigationBar

@synthesize leftButton=_leftButton, rightButton=_rightButton, contentView=_contentView;

- (CGRect)rectForLeftButton:(CGSize)size {
  if (!_leftButton) return CGRectZero;
  CGRect leftCenter = YKCGRectToCenter(_leftButton.frame.size, size);
  return CGRectMake(5, leftCenter.origin.y, _leftButton.frame.size.width, _leftButton.frame.size.height);
}

- (CGRect)rectForRightButton:(CGSize)size {
  if (!_rightButton) return CGRectZero;
  CGRect rightCenter = YKCGRectToCenter(_rightButton.frame.size, size);
  return CGRectMake(size.width - _rightButton.frame.size.width - 5, rightCenter.origin.y, _rightButton.frame.size.width, _rightButton.frame.size.height);
}

- (CGRect)rectForContentView:(CGSize)size {
  CGRect leftRect = [self rectForLeftButton:size];
  CGRect rightRect = [self rectForRightButton:size];
  
  CGFloat maxContentWidth = (size.width - (leftRect.size.width + rightRect.size.width + 10));
  CGSize contentSize = [_contentView sizeThatFits:CGSizeMake(maxContentWidth, size.height)];
  if (YKCGSizeIsZero(contentSize)) contentSize = _defaultContentViewSize;
  CGRect contentCenter = YKCGRectToCenter(contentSize, size);
  
  // If content view width is more than the max, then left align;
  // If the left position of the content will overlap the left button, then also left align;
  // Otherwise center it.
  if (contentCenter.origin.x > maxContentWidth || contentCenter.origin.x < leftRect.size.width + 10) {
    return CGRectMake(leftRect.size.width + 10, contentCenter.origin.y, maxContentWidth, contentSize.height);
  } else {
    return CGRectMake(contentCenter.origin.x, contentCenter.origin.y, contentSize.width, contentSize.height);
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];  
  _leftButton.frame = [self rectForLeftButton:self.frame.size];
  _rightButton.frame = [self rectForRightButton:self.frame.size];
  _contentView.frame = [self rectForContentView:self.frame.size];
}

- (void)setTitle:(NSString *)title animated:(BOOL)animated {
  UILabel *label = [[UILabel alloc] init];
  label.font = [UIFont boldSystemFontOfSize:20];
  label.minimumFontSize = 14;
  label.shadowColor = [UIColor darkGrayColor];
  label.textColor = [UIColor whiteColor];
  label.textAlignment = UITextAlignmentCenter;
  label.opaque = NO;
  label.contentMode = UIViewContentModeCenter;
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  label.backgroundColor = [UIColor clearColor];
  label.text = title;
  label.userInteractionEnabled = NO;
  [self setContentView:label animated:animated];
  [label release];
}

- (void)setContentView:(UIView *)contentView {
  [self setContentView:contentView animated:NO];
}

- (void)setContentView:(UIView *)contentView animated:(BOOL)animated {  
  if (animated && contentView) {
    UIView *oldContentView = _contentView;
    contentView.alpha = 0.0;
    _contentView = contentView;
    _defaultContentViewSize = contentView.frame.size;
    _contentView.frame = [self rectForContentView:self.frame.size];
    [self addSubview:_contentView];
    [UIView animateWithDuration:0.5 animations:^{
      oldContentView.alpha = 0.0;
      contentView.alpha = 1.0;
    } completion:^(BOOL finished) {
      [oldContentView removeFromSuperview];
      oldContentView.alpha = 1.0;
    }];
  } else {
    [_contentView removeFromSuperview];
    _contentView = nil;
    if (contentView) {
      _contentView = contentView;
      _defaultContentViewSize = contentView.frame.size;
      [self addSubview:_contentView];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
}

- (void)setLeftButton:(UIControl *)leftButton {
  [_leftButton removeFromSuperview];
  _leftButton = nil;
  if (leftButton) {
    _leftButton = leftButton;
    [self addSubview:_leftButton];
  }
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setRightButton:(UIControl *)rightButton {
  [_rightButton removeFromSuperview];
  _rightButton = nil;
  if (rightButton) {
    _rightButton = rightButton;
    [self addSubview:_rightButton];
  }
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

@end
