//
//  YKUIActivityView.m
//  YelpIPhone
//
//  Created by Gabriel Handford on 12/14/10.
//  Copyright 2010 Yelp. All rights reserved.
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

#import "YKUIActivityView.h"
#import "YKCGUtils.h"

@implementation YKUIActivityView

@synthesize activityStyle=_activityStyle, label=_label;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.opaque = YES;
    self.backgroundColor = [UIColor blackColor];
  }
  return self;
}

- (void)dealloc {
  [_activityIndicator release];
  _activityIndicator = nil;
  [_label release];
  _label = nil;
  [super dealloc];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _activityIndicator.frame = YKCGRectToCenter(_activityIndicator.frame.size, self.frame.size);
  _label.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

- (void)_setActivityEnabled:(BOOL)activityEnabled {  
  _activityEnabled = activityEnabled;
  if (!_activityEnabled) {
    [_activityIndicator stopAnimating];
    _activityIndicator.hidden = YES;  
  } else {
    if (!_activityIndicator) {
      _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityStyle];
      [self addSubview:_activityIndicator];
      [self setNeedsLayout];
    } 
    [_activityIndicator startAnimating];
    _activityIndicator.hidden = NO;
  }
}

- (void)setActivityStyle:(UIActivityIndicatorViewStyle)activityStyle {
  _activityStyle = activityStyle;
  if (_activityIndicator) _activityIndicator.activityIndicatorViewStyle = activityStyle;
}

- (UILabel *)label {
  if (!_label) {
    _label = [[UILabel alloc] init];
    _label.textAlignment = UITextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.contentMode = UIViewContentModeCenter;
    _label.numberOfLines = 0;
    _label.font = [UIFont boldSystemFontOfSize:16.0];
    _label.textColor = [UIColor whiteColor];      
    [self setNeedsLayout];
  }
  return _label;
}

- (void)setText:(NSString *)text {
  if (!text) {
    self.label.hidden = YES;
  } else {
    [self addSubview:self.label];
    self.label.text = text;
    self.label.hidden = NO;   
  }
}

- (void)setAnimating:(BOOL)animating {
  if (animating) [self start];
  else [self stop];
}

- (void)start {
  self.hidden = NO;
  [self _setActivityEnabled:YES];
  [self setText:nil];
}

- (void)stop {
  self.hidden = YES;
  [self _setActivityEnabled:NO];
  [self setText:nil];
}

- (void)setErrorWithDescription:(NSString *)description {
  self.hidden = NO;
  [self _setActivityEnabled:NO];
  [self setText:description];
}

@end
