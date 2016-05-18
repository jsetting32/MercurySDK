//
//  JSCheckoutCollectionViewFlowLayout.m
//  MercurySDK
//
//  Created by John Setting on 5/18/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "JSCheckoutCollectionViewFlowLayout.h"

@implementation JSCheckoutCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributesArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    BOOL headerVisible = NO;
    BOOL footerVisible = NO;
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerVisible = YES;
            attributes.frame = CGRectMake(self.collectionView.contentOffset.x, 0, 1, 1);//self.headerReferenceSize.width, self.headerReferenceSize.height);
            //            attributes.alpha = HEADER_ALPHA;
            attributes.zIndex = 2;
        }
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
            footerVisible = YES;
            attributes.frame = CGRectMake(self.collectionView.contentOffset.x, 0, 1, 1);//self.headerReferenceSize.width, self.headerReferenceSize.height);
            //            attributes.alpha = HEADER_ALPHA;
            attributes.zIndex = 2;
        }
    }
    
    if (!headerVisible) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                                                atIndexPath:[NSIndexPath
                                                                                                                                             indexPathForItem:0
                                                                                                                                             inSection:0]];
        [attributesArray addObject:attributes];
    }
    
    if (!footerVisible) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                                                atIndexPath:[NSIndexPath
                                                                                                                                             indexPathForItem:0
                                                                                                                                             inSection:0]];
        [attributesArray addObject:attributes];
    }
    
    return attributesArray;
}

@end
