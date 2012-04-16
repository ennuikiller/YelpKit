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
  
  CGFloat maxContentWidth = (size.width - (leftRect.size.width + rightRect.size.width + 20));
  CGSize contentSize = [_contentView sizeThatFits:CGSizeMake(maxContentWidth, size.height)];
  if (YKCGSizeIsZero(contentSize)) contentSize = _defaultContentViewSize;
  // Let the content center adjust up a tiny bit
  CGRect contentCenter = YKCGRectToCenter(contentSize, CGSizeMake(size.width, size.height - 1));
  
  // If content view width is more than the max, then left align.
  // If the left position of the content will overlap the left button, then also left align.
  // If the right position of the content will overlap the right button, then right align.
  // Otherwise center it.
  if (contentCenter.origin.x > maxContentWidth || contentCenter.origin.x < leftRect.size.width + 10) {
    return CGRectMake(leftRect.size.width + 10, contentCenter.origin.y, maxContentWidth, contentSize.height);
  } else if (!_leftButton && _rightButton && contentCenter.origin.x + contentCenter.size.width > (rightRect.origin.x - 10)) {
    return CGRectMake(rightRect.origin.x - maxContentWidth - 10, contentCenter.origin.y, maxContentWidth, contentSize.height);
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
  label.minimumFontSize = 16;
  label.numberOfLines = 1;
  label.lineBreakMode = UILineBreakModeMiddleTruncation;
  label.adjustsFontSizeToFitWidth = YES;
  label.shadowColor = [UIColor darkGrayColor];
  label.textColor = [UIColor whiteColor];
  label.textAlignment = UITextAlignmentCenter;
  label.opaque = NO;
  label.contentMode = UIViewContentModeCenter;
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
  if (contentView) {
    contentView.contentMode = UIViewContentModeCenter;
  }
  
  if (animated) {
    UIView *oldContentView = _contentView;    
    _contentView = contentView;
    if (_contentView) {
      _contentView.alpha = 0.0;
      _defaultContentViewSize = _contentView.frame.size;
      _contentView.frame = [self rectForContentView:self.frame.size];
      [self addSubview:_contentView];
    }
    [UIView animateWithDuration:0.5 animations:^{
      oldContentView.alpha = 0.0;
      _contentView.alpha = 1.0;
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

- (void)setLeftButton:(UIView *)leftButton {
  [self setLeftButton:leftButton animated:NO];
}

- (void)setLeftButton:(UIView *)leftButton animated:(BOOL)animated {
  if (animated) {
    UIView *oldLeftButton = _leftButton;
    _leftButton = leftButton;
    if (_leftButton) {
      _leftButton.alpha = 0.0;
      _leftButton.frame = [self rectForLeftButton:self.frame.size];
      [self addSubview:_leftButton];
    }
    [UIView animateWithDuration:0.5 animations:^{
      oldLeftButton.alpha = 0.0;
      _leftButton.alpha = 1.0;
    } completion:^(BOOL finished) {
      [oldLeftButton removeFromSuperview];
      oldLeftButton.alpha = 1.0;
    }];
  } else {
    [_leftButton removeFromSuperview];
    _leftButton = nil;
    if (leftButton) {
      _leftButton = leftButton;
      [self addSubview:_leftButton];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
}

- (void)setRightButton:(UIView *)rightButton {
  [self setRightButton:rightButton animated:NO];
}

- (void)setRightButton:(UIView *)rightButton animated:(BOOL)animated {
  if (animated) {
    UIView *oldRightButton = _rightButton;
    _rightButton = rightButton;
    if (_rightButton) {
      _rightButton.alpha = 0.0;
      _rightButton.frame = [self rectForRightButton:self.frame.size];
      [self addSubview:_rightButton];
    }
    [UIView animateWithDuration:0.5 animations:^{
      oldRightButton.alpha = 0.0;
      _rightButton.alpha = 1.0;
    } completion:^(BOOL finished) {
      [oldRightButton removeFromSuperview];
      oldRightButton.alpha = 1.0;
    }];
  } else {
    [_rightButton removeFromSuperview];
    _rightButton = nil;
    if (rightButton) {
      _rightButton = rightButton;
      [self addSubview:_rightButton];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
  }
}

@end
