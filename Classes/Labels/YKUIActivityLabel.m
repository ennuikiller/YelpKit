//
//  YKUIActivityLabel.m
//  YelpKit
//
//  Created by Gabriel Handford on 4/6/10.
//  Copyright 2010 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "YKUIActivityLabel.h"
#import <GHKitIOS/GHNSString+Utils.h>
#import "YKCGUtils.h"
#import "YKLocalized.h"

@implementation YKUIActivityLabel

@synthesize textLabel=_textLabel, detailLabel=_detailLabel, imageView=_imageView, hidesWhenStopped=_hidesWhenStopped;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.layout = [YKLayout layoutForView:self];
    self.backgroundColor = [UIColor whiteColor];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.text = YKLocalizedString(@"Loading...");
    _textLabel.font = [UIFont systemFontOfSize:16.0];
    _textLabel.textColor = [UIColor colorWithWhite:0.25 alpha:1.0];
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.contentMode = UIViewContentModeCenter;
    _textLabel.textAlignment = UITextAlignmentLeft;
    [self addSubview:_textLabel];
    [_textLabel release];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.hidesWhenStopped = YES;
    [self addSubview:_activityIndicator];
    [_activityIndicator release];  

    _imageView = [[UIImageView alloc] init];
    _imageView.hidden = YES;
    [self addSubview:_imageView];
    [_imageView release];
  }
  return self;
}

- (CGSize)layout:(id<YKLayout>)layout size:(CGSize)size {
  CGFloat width = size.width - 10;
  
  CGSize lineSize = CGSizeZero;
  CGSize textLabelSize = CGSizeZero;
  if (![NSString gh_isBlank:_textLabel.text]) {
    textLabelSize = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:CGSizeMake(width, size.height) lineBreakMode:UILineBreakModeTailTruncation];    
    lineSize.width += textLabelSize.width;
    lineSize.height += textLabelSize.height;
  }
  
  CGSize detailLabelSize = CGSizeZero;
  if (![NSString gh_isBlank:_detailLabel.text]) {
    detailLabelSize = [_detailLabel.text sizeWithFont:_detailLabel.font constrainedToSize:CGSizeMake(width, size.height) lineBreakMode:UILineBreakModeTailTruncation];    
    lineSize.height += detailLabelSize.height + 2;
  }
  
  if (_activityIndicator.isAnimating) {
    lineSize.width += _activityIndicator.frame.size.width + 4;
    lineSize.height = MAX(lineSize.height, _activityIndicator.frame.size.height);
  }
  
  if (!_imageView.hidden) {
    lineSize.width += _imageView.image.size.width + 4;
    lineSize.height = MAX(lineSize.height, _imageView.image.size.height);
  }
  
  if (lineSize.height == 0) return CGSizeMake(size.width, self.frame.size.height);
  
  CGFloat x = YKCGFloatToCenter(lineSize.width, width, 0);
  CGFloat centerY = YKCGFloatToCenter(lineSize.height, size.height, 0);
  CGFloat height = lineSize.height;
  
  if (_activityIndicator.isAnimating) {
    [layout setOrigin:CGPointMake(x, centerY) view:_activityIndicator];
    x += _activityIndicator.frame.size.width + 4;
  }

  if (!_imageView.hidden) {
    [layout setOrigin:CGPointMake(x, centerY) view:_imageView];
    x += _imageView.image.size.width + 4;
  }

  if (![NSString gh_isBlank:_textLabel.text]) {
    [layout setFrame:CGRectMake(x, centerY, textLabelSize.width, textLabelSize.height) view:_textLabel];
    centerY += textLabelSize.height + 2;
  }
  
  if (![NSString gh_isBlank:_detailLabel.text]) {
    x = YKCGFloatToCenter(detailLabelSize.width, size.width, 0);
    [layout setFrame:CGRectMake(x, centerY, detailLabelSize.width, detailLabelSize.height) view:_detailLabel];
    centerY += detailLabelSize.height;
    height += detailLabelSize.height;
  }
  return CGSizeMake(size.width, height);
}

- (void)startAnimating {
  if (_hidesWhenStopped) self.hidden = NO;
  _imageView.hidden = YES;
  [_activityIndicator startAnimating];
  [self setNeedsLayout];
}

- (void)stopAnimating {
  if (_hidesWhenStopped) self.hidden = YES;
  [_activityIndicator stopAnimating];
  if (_imageView.image)
    _imageView.hidden = NO;
  [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
  self.textLabel.text = text;
  [self setNeedsLayout];
}

- (void)setAnimating:(BOOL)animating {
  if (animating) [self startAnimating];
  else [self stopAnimating];
}

- (BOOL)isAnimating {
  return [_activityIndicator isAnimating];  
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
  _activityIndicator.activityIndicatorViewStyle = activityIndicatorViewStyle;
}

- (UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
  return _activityIndicator.activityIndicatorViewStyle;
}

- (void)setImage:(UIImage *)image {
  if (image) {
    _activityIndicator.hidden = YES;
    _imageView.hidden = NO;
    _imageView.image = image;
  } else {
    _activityIndicator.hidden = NO;
    _imageView.hidden = YES;
  }
  [self setNeedsLayout];
  [self setNeedsDisplay];
}

- (void)setDetailText:(NSString *)detailText {
  self.detailLabel.text = detailText;
  [self setNeedsLayout];
}

- (UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont systemFontOfSize:14.0];
    _detailLabel.textColor = [UIColor colorWithWhite:0.45 alpha:1.0];
    _detailLabel.textAlignment = UITextAlignmentCenter;
    _detailLabel.contentMode = UIViewContentModeCenter;
    [self addSubview:_detailLabel];
    [_detailLabel release];
    [self setNeedsLayout];
  }
  return _detailLabel;
}

@end
