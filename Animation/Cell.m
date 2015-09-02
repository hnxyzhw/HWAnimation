//
//  Created by Marvin on 15/9/1.
//  Copyright (c) 2015年 Marvin. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        self.label.layer.cornerRadius = self.label.frame.size.width / 2;
        self.label.layer.masksToBounds = YES;
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:20.0];
        self.label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];;
//        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

@end
