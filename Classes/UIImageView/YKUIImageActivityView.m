//
//  YKUIImageActivityView.m
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

#import "YKUIImageActivityView.h"


@implementation YKUIImageActivityView 

@synthesize activityView=_activityView;

@dynamic image, status, URLString;

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    _activityView = [[YKUIActivityView alloc] init];
    [self addSubview:_activityView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _activityView.frame = self.bounds;
}

- (void)dealloc {
  [_activityView release];
  [super dealloc];
}

- (void)startActivity {
  [_activityView start];
}

- (void)stopActivity {
  [_activityView stop];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  [_activityView setBackgroundColor:backgroundColor];
}

- (void)setActivityStyle:(UIActivityIndicatorViewStyle)activityStyle {
  [_activityView setActivityStyle:activityStyle];
}

- (UIActivityIndicatorViewStyle)activityStyle {
  return _activityView.activityStyle;
}

- (void)setURLString:(NSString *)URLString {
  if ([URLString isEqual:[NSNull null]]) URLString = nil;
  if (!URLString) {
    self.image = nil;
    [self setURLString:nil loadingImage:nil defaultImage:nil];
    [_activityView stop];
  } else {
    [_activityView start];
    [self setURLString:URLString loadingImage:nil defaultImage:nil];
  }
}

- (void)imageLoaderDidStart:(YKImageLoader *)imageLoader {
  [super imageLoaderDidStart:imageLoader];
  [_activityView start];
}

- (void)imageLoader:(YKImageLoader *)imageLoader didUpdateStatus:(YKImageLoaderStatus)status image:(UIImage *)image { 
  [super imageLoader:imageLoader didUpdateStatus:status image:image];
  if (image) {
    [_activityView stop];
  }
}

- (void)imageLoader:(YKImageLoader *)imageLoader didError:(YKError *)error {
  [super imageLoader:imageLoader didError:error];
  [_activityView stop];
}

- (void)imageLoaderDidCancel:(YKImageLoader *)imageLoader { 
  [super imageLoaderDidCancel:imageLoader];
  [_activityView stop];
}

@end
