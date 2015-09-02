//
//  Created by Marvin on 15/9/1.
//  Copyright (c) 2015年 Marvin. All rights reserved.
//

#import "LineLayout.h"

#define ITEM_SIZE 60.0
#define ACTIVE_DISTANCE 50
#define ZOOM_FACTOR 0.2

@implementation LineLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //  确定了缩进
        self.sectionInset = UIEdgeInsetsMake([UIScreen mainScreen].bounds.size.height - ITEM_SIZE / 2 - 132 / 2 , ITEM_SIZE * 2.6, 132 / 2 - ITEM_SIZE / 2, ITEM_SIZE * 2.6);
        //  每个item在水平方向的最小间距
        self.minimumLineSpacing = ITEM_SIZE/4;
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

//  初始的layout外观将由该方法返回的UICollctionViewLayoutAttributes来决定
//滑动的时候让item有放大的动画效果
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}

//  自动对齐到网格
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //  proposedContentOffset是没有对齐到网格时本来应该停下来的位置
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //  当前显示的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    //  取当前显示的item
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    //  对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end