//
//  YKUILayoutView.m
//  YelpKit
//
//  Created by Gabriel Handford on 6/19/09.
//  Copyright 2009 Yelp. All rights reserved.
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

#import "YKUILayoutView.h"
#import "YKCGUtils.h"


@implementation YKUILayoutView

@synthesize layout=_layout, needsLayoutBlock=_needsLayoutBlock;

- (void)sharedInit { }

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self sharedInit];
  }
  return self;
}

- (void)dealloc {
  [_layout clear];
  [_layout release];
  Block_release(_needsLayoutBlock);
  [super dealloc];
}

- (void)setFrame:(CGRect)frame {
  if (_layout && !YKCGRectIsEqual(self.frame, frame)) [_layout setNeedsLayout];
  [super setFrame:frame];
}

#pragma mark Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  YKLayoutAssert(self, _layout);
  if (_layout) {
    [_layout layoutSubviews:self.frame.size];
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  YKLayoutAssert(self, _layout);
  if (_layout) {
    return [_layout sizeThatFits:size];
  }
  return [super sizeThatFits:size];
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [_layout setNeedsLayout];
}

- (void)notifyNeedsLayout:(BOOL)animated {
  if (_needsLayoutBlock != NULL) _needsLayoutBlock(self, animated);
  else [self setNeedsLayout];
}

#pragma mark Drawing/Layout

- (void)layoutView {
  NSAssert(_layout, @"Missing layout instance");
  [_layout setNeedsLayout];
  [_layout layoutSubviews:self.frame.size];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  [_layout drawSubviewsInRect:self.bounds];
}

- (void)drawInRect:(CGRect)rect {
  [_layout drawSubviewsInRect:rect];
}

@end
