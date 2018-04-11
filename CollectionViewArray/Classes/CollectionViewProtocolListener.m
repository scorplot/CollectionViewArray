//
//  CollectionViewProtocolListener.m
//  Pods
//
//  Created by aruisi on 2017/7/19.
//
//

#import "CollectionViewProtocolListener.h"
#import "objc/runtime.h"
#import "NSMutableArray+Listener.h"
#import "CircleReferenceCheck.h"

#pragma mark  -

@interface CollectionViewProtocolListener ()
@property(nonatomic,strong) NSMutableArray * observerArray;
@property(nonatomic,weak)id<UICollectionViewDelegate>delegate;
@end

typedef void (*setDelegate_IMP)(id self,SEL _cmd ,id delegate);
static setDelegate_IMP origin_setDelegate_IMP = nil;
static void replace_setDelegate_IMP(id self,SEL _cmd ,id delegate){
    if ([self isKindOfClass:[UICollectionView class]]) {
        if (!delegate) {
            origin_setDelegate_IMP(self, _cmd, delegate);
            return;
        }
        id<UICollectionViewDelegate> tableDelegate = [self delegate];
        if ([delegate isKindOfClass:[CollectionViewProtocolListener class]]) {
            [(CollectionViewProtocolListener*)delegate setDelegate:tableDelegate];
            origin_setDelegate_IMP(self, _cmd, delegate);
        } else if ([tableDelegate isKindOfClass:[CollectionViewProtocolListener class]]) {
            [(CollectionViewProtocolListener*)tableDelegate setDelegate:delegate];
            if (delegate == nil) {
                origin_setDelegate_IMP(self, _cmd, nil);
            }
        } else {
            origin_setDelegate_IMP(self, _cmd, delegate);
        }
    } else {
        origin_setDelegate_IMP(self, _cmd, delegate);
    }
}

@implementation CollectionViewProtocolListener
+(void)load {
    Method method;
    method = class_getInstanceMethod([UICollectionView class], @selector(setDelegate:));
    origin_setDelegate_IMP =(setDelegate_IMP)method_setImplementation(method, (IMP)replace_setDelegate_IMP);
}

-(NSMutableArray *)observerArray{
    if(!_observerArray) {
        _observerArray = [NSMutableArray array];
    }
    return _observerArray;
}
-(BOOL)respondsToSelector:(SEL)aSelector{
    
    if (sel_isEqual(aSelector, @selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)) && !_listener.viewForSupplementaryElementOfKindatIndexPath) {
        return NO;
    }
    /* Reordering Items*/
    if (sel_isEqual(aSelector, @selector(collectionView:canMoveItemAtIndexPath:)) && !_listener.canMoveItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:moveItemAtIndexPath:toIndexPath:)) && !_listener.moveItemAtIndexPathtoIndexPath) {
        return NO;
    }
    
    /*Instance Method */
    
    
    if (sel_isEqual(aSelector, @selector(collectionView:indexPathForIndexTitle:atIndex:)) && !_listener.indexPathForIndexTitleAtIndex) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(indexTitlesForCollectionView:)) && !_listener.indexTitlesForCollectionView ) {
        return NO;
    }
    
    /* Managing the Selected Cells */
    if (sel_isEqual(aSelector, @selector(collectionView:shouldSelectItemAtIndexPath:)) && !_listener.shouldSelectItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:didSelectItemAtIndexPath:)) && !_listener.didSelectItemAtIndexPath ) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:shouldDeselectItemAtIndexPath:)) && !_listener.shouldDeselectItemAtIndexPath) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:didDeselectItemAtIndexPath:)) && !_listener.didDeselectItemAtIndexPath) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:shouldHighlightItemAtIndexPath:)) && !_listener.shouldHighlightItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:didHighlightItemAtIndexPath:)) && !_listener.didHighlightItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:didUnhighlightItemAtIndexPath:)) && !_listener.didUnhighlightItemAtIndexPath) {
        return NO;
    }
    
    /*Tracking the Addition and Removal of Views*/
    if (sel_isEqual(aSelector, @selector(collectionView:willDisplayCell:forItemAtIndexPath:)) && !_listener.willDisplayCellForItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:)) && !_listener.wilDisplaySupplementaryViewForElementKindAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:)) && !_listener.didEndDisplayingCellForItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:)) && !_listener.didEndDisplayingSupplementaryViewForElementKindAtIndexPath) {
        return NO;
    }
    
    /*Handling Layout Changes*/
    if (sel_isEqual(aSelector, @selector(collectionView:transitionLayoutForOldLayout:newLayout:)) && !_listener.transitionLayoutForOldLayoutWithNewLayout) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:targetContentOffsetForProposedContentOffset:)) && !_listener.targetContentOffsetForProposedContentOffset) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:targetIndexPathForMoveFromItemAtIndexPath:toProposedIndexPath:)) && !_listener.targetIndexPathForMoveFromItemAtIndexPathToProposedIndexPath) {
        return NO;
    }
    
    /*Managing Actions for Cells*/
    if (sel_isEqual(aSelector, @selector(collectionView:shouldShowMenuForItemAtIndexPath:)) && !_listener.shouldShowMenuForItemAtIndexPath) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:canPerformAction:forItemAtIndexPath:withSender:)) && !_listener.canPerformActionForItemAtIndexPath) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:performAction:forItemAtIndexPath:withSender:)) && !_listener.performActionForItemAtIndexPath) {
        return NO;
    }
    /*Managing Focus in a Collection View */
    if (sel_isEqual(aSelector, @selector(collectionView:canFocusItemAtIndexPath:)) && !_listener.canFocusItemAtIndexPath) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(indexPathForPreferredFocusedViewInTableView:)) && !_listener.indexPathForPreferredFocusedViewInCollectionView) {
        return NO;
    }
    if (@available(iOS 9_0, *)) {
        if (sel_isEqual(aSelector, @selector(collectionView:shouldUpdateFocusInContext:)) && !_listener.shouldUpdateFocusInContext) {
            return NO;
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 9_0, *)) {
        if (sel_isEqual(aSelector, @selector(collectionView:didUpdateFocusInContext:withAnimationCoordinator:)) && !_listener.didUpdateFocusInContextWithAnimationCoordinator) {
            return NO;
        }
    } else {
        // Fallback on earlier versions
    }
    
    
    /*Getting the Size of Items*/
    
    if (sel_isEqual(aSelector, @selector(collectionView:layout:sizeForItemAtIndexPath:)) && !_listener.sizeForItemAtIndexPath) {
        return NO;
    }
    /*Getting the Section Spacing*/
    if (sel_isEqual(aSelector, @selector(collectionView:layout:insetForSectionAtIndex:)) && !_listener.layoutInsetForSectionAtIndex ) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)) && !_listener.minimumLineSpacingForSectionAtIndex) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)) && !_listener.minimumInteritemSpacingForSectionAtIndex) {
        return NO;
    }
    
    /*Getting the Header and Footer Sizes*/
    if (sel_isEqual(aSelector, @selector(collectionView:layout:referenceSizeForHeaderInSection:)) && !_listener.layoutReferenceSizeForHeaderInSection) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:layout:referenceSizeForFooterInSection:)) && !_listener.layoutReferenceSizeForFooterInSection) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(collectionView:cancelPrefetchingForItemsAtIndexPaths:)) && !_listener.cancelPrefetchingForItemsAtIndexPaths) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(collectionView:prefetchItemsAtIndexPaths:)) && !_listener.prefetchItemsAtIndexPaths) {
        return NO;
    }
    
#pragma mark  - UIScrollViewDelegate
    if (sel_isEqual(aSelector, @selector(scrollViewDidScroll:))&&!_listener.scrollViewDidScroll) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewDidZoom:))&&!_listener.scrollViewDidZoom) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewWillBeginDragging:))&&!_listener.scrollViewWillBeginDragging) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:))&&!_listener.scrollViewWillEndDragging) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewDidEndDragging:willDecelerate:))&&!_listener.scrollViewDidEndDragging) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewWillBeginDecelerating:))&&!_listener.scrollViewWillBeginDecelerating) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewDidEndDecelerating:))&&!_listener.scrollViewDidEndDecelerating) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(scrollViewDidEndScrollingAnimation:))&&!_listener.scrollViewDidEndScrollingAnimation) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(viewForZoomingInScrollView:))&&!_listener.viewForZoomingInScrollView) {
        return NO;
    }
    
    if (sel_isEqual(aSelector, @selector(scrollViewWillBeginZooming:withView:))&&!_listener.scrollViewWillBeginZooming) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewDidEndZooming:withView:atScale:))&&!_listener.scrollViewDidEndZooming) {
        return NO;
    }
   
    if (sel_isEqual(aSelector, @selector(scrollViewShouldScrollToTop:))&&!_listener.scrollViewShouldScrollToTop) {
        return NO;
    }
    if (sel_isEqual(aSelector, @selector(scrollViewDidScrollToTop:))&&!_listener.scrollViewDidScrollToTop) {
        return NO;
    }
    if (@available(iOS 11.0, *)) {
        if (sel_isEqual(aSelector, @selector(scrollViewDidChangeAdjustedContentInset:))&&!_listener.scrollViewDidChangeAdjustedContentInset) {
            return NO;
        }
    } else {
        // Fallback on earlier versions
    }
    
    return [super respondsToSelector:aSelector];
}
#pragma mark  - UICollecionViewDataSourcePrefectching
/* UICollecionView DataSource Prefectching 协议 */
- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    _listener.prefetchItemsAtIndexPaths(collectionView,indexPaths);
}

- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    _listener.cancelPrefetchingForItemsAtIndexPaths(collectionView,indexPaths);
}

#pragma mark  - CollectionView Delegate Flowlayout
/* CollectionView Delegate Flowlayout 协议 */
/*Getting the Header and Footer Sizes*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return _listener.layoutReferenceSizeForFooterInSection(collectionView,collectionViewLayout,section);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return _listener.layoutReferenceSizeForHeaderInSection(collectionView,collectionViewLayout,section);
}

/*Getting the Section Spacing*/
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return _listener.minimumInteritemSpacingForSectionAtIndex(collectionView,collectionViewLayout,section);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return _listener.minimumLineSpacingForSectionAtIndex(collectionView,collectionViewLayout,section);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return _listener.layoutInsetForSectionAtIndex(collectionView,collectionViewLayout,section);;
}
/*Getting the Size of Items*/

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if(_listener.collectionViewStyle == UICollectionViewStylePlain){
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
    }
    return _listener.sizeForItemAtIndexPath(collectionView,collectionViewLayout,indexPath,object);
}


#pragma mark  - CollectionView DeleteGate
/* CollectionView DeleteGate 协议  IMP 形式 */
/*Managing Focus in a Collection View */
-(void)collectionView:(UICollectionView *)collectionView didUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator API_AVAILABLE(ios(9.0)){
    _listener.didUpdateFocusInContextWithAnimationCoordinator(collectionView,context,coordinator);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context API_AVAILABLE(ios(9.0)){
    return _listener.shouldUpdateFocusInContext(collectionView,context);
}
-(NSIndexPath *)indexPathForPreferredFocusedViewInCollectionView:(UICollectionView *)collectionView{
    return _listener.indexPathForPreferredFocusedViewInCollectionView(collectionView);
}
-(BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath{
    return _listener.canFocusItemAtIndexPath(collectionView,indexPath);
}


/*Managing Actions for Cells*/
-(void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    _listener.performActionForItemAtIndexPath(collectionView,action,indexPath,sender);
}

-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    return _listener.canPerformActionForItemAtIndexPath(collectionView,action,indexPath,sender);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _listener.shouldShowMenuForItemAtIndexPath(collectionView,indexPath);
}

/*Handling Layout Changes*/
-(NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath{
    return _listener.targetIndexPathForMoveFromItemAtIndexPathToProposedIndexPath(collectionView,originalIndexPath,proposedIndexPath);
}
-(CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    return _listener.targetContentOffsetForProposedContentOffset(collectionView,proposedContentOffset);
}

-(UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout{
    return _listener.transitionLayoutForOldLayoutWithNewLayout(collectionView,fromLayout,toLayout);
}

/*Tracking the Addition and Removal of Views*/
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    _listener.didEndDisplayingSupplementaryViewForElementKindAtIndexPath(collectionView,view,elementKind,indexPath);
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain){
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
        
    }
    
    _listener.didEndDisplayingCellForItemAtIndexPath(collectionView,cell,indexPath,object);
}
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    _listener.wilDisplaySupplementaryViewForElementKindAtIndexPath(collectionView,view,elementKind,indexPath);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain){
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
        
    }
    _listener.willDisplayCellForItemAtIndexPath(collectionView,cell,indexPath,object);
}

/*Managing Cell Highlighting */
-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    _listener.didUnhighlightItemAtIndexPath(collectionView,indexPath);
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    _listener.didHighlightItemAtIndexPath(collectionView,indexPath);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return _listener.shouldHighlightItemAtIndexPath(collectionView,indexPath);
}

/* Managing the Selected Cells */

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
    }
    _listener.didDeselectItemAtIndexPath(collectionView,indexPath,object);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
    }
    return _listener.shouldDeselectItemAtIndexPath(collectionView,indexPath,object);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
    }
    _listener.didSelectItemAtIndexPath(collectionView,indexPath,object);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
    }
    return _listener.shouldSelectItemAtIndexPath(collectionView,indexPath,object);
}

/* CollectionView DataSource 协议 */
/*Instance Method */
-(NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView{
    return _listener.indexTitlesForCollectionView(collectionView);
}

-(NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return  _listener.indexPathForIndexTitleAtIndex(collectionView,title,index);
}

#pragma mark  - CollectionView DataSource

/* Reordering Items*/
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    _listener.moveItemAtIndexPathtoIndexPath(collectionView, sourceIndexPath, destinationIndexPath);
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return _listener.canMoveItemAtIndexPath(collectionView,indexPath);
}


/* Getting views for Items */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return _listener.viewForSupplementaryElementOfKindatIndexPath(collectionView,kind,indexPath);
}


#pragma mark - set Property methods
-(void)setListener:(CollectionViewArray *)binder{
    _listener = binder;
    
    /* Getting Views for Items */
    NSAssert(!checkCircleReference(binder.cellForItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.viewForSupplementaryElementOfKindatIndexPath, binder), @"raise a block circle reference");

    /* Reordering Items */
    NSAssert(!checkCircleReference(binder.canMoveItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.moveItemAtIndexPathtoIndexPath, binder), @"raise a block circle reference");
    
    /* Instance Methods */
    NSAssert(!checkCircleReference(binder.indexPathForIndexTitleAtIndex, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.indexTitlesForCollectionView, binder), @"raise a block circle reference");
    
    /*Managing the selected cells */
    NSAssert(!checkCircleReference(binder.shouldSelectItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didSelectItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.shouldDeselectItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didDeselectItemAtIndexPath, binder), @"raise a block circle reference");
    
    /*Mananing cell Highting */
    NSAssert(!checkCircleReference(binder.shouldHighlightItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didHighlightItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didUnhighlightItemAtIndexPath, binder), @"raise a block circle reference");
    
    /*Tracking the addition adn removal of views*/
    NSAssert(!checkCircleReference(binder.willDisplayCellForItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.wilDisplaySupplementaryViewForElementKindAtIndexPath, binder    ), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didEndDisplayingCellForItemAtIndexPath, binder), @"raise a block circle reference");
    NSAssert(!checkCircleReference(binder.didEndDisplayingSupplementaryViewForElementKindAtIndexPath, binder), @"raise a block circle reference");
    
    /*Handing layout Changes*/
    NSAssert(!checkCircleReference(binder.transitionLayoutForOldLayoutWithNewLayout, binder), @"raise a block circle reference ,reason: transitionLayoutForOldLayoutWithNewLayout ");
    NSAssert(!checkCircleReference(binder.targetContentOffsetForProposedContentOffset, binder), @"raise a block circle reference reason: targetContentOffsetForProposedContentOffset");
    NSAssert(!checkCircleReference(binder.targetIndexPathForMoveFromItemAtIndexPathToProposedIndexPath, binder), @"raise a block circle reference reason: targetIndexPathForMoveFromItemAtIndexPathToProposedIndexPath");
    
    /*manaing actions of Cells*/
    NSAssert(!checkCircleReference(binder.shouldShowMenuForItemAtIndexPath, binder), @"raise a block circle reference reason: shouldShowMenuForItemAtIndexPath");
    NSAssert(!checkCircleReference(binder.canPerformActionForItemAtIndexPath, binder), @"raise a block circle reference reason: canPerformActionForItemAtIndexPath");
    NSAssert(!checkCircleReference(binder.performActionForItemAtIndexPath, binder), @"raise a block circle reference reason: performActionForItemAtIndexPath");
    
    /*Managing focus in a Collection view*/
    NSAssert(!checkCircleReference(binder.canFocusItemAtIndexPath, binder), @"raise a block circle reference reason: canFocusItemAtIndexPath");
    NSAssert(!checkCircleReference(binder.indexPathForPreferredFocusedViewInCollectionView, binder), @"raise a block circle reference reason: indexPathForPreferredFocusedViewInCollectionView");
    if (@available(iOS 9_0, *)) {
        NSAssert(!checkCircleReference(binder.shouldUpdateFocusInContext, binder), @"raise a block circle reference reason: shouldUpdateFocusInContext");
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 9_0, *)) {
        NSAssert(!checkCircleReference(binder.didUpdateFocusInContextWithAnimationCoordinator, binder), @"raise a block circle reference reason: didUpdateFocusInContextWithAnimationCoordinatorv");
    } else {
        // Fallback on earlier versions
    }
    
    /* Getting the Section Spacing */
    NSAssert(!checkCircleReference(binder.sizeForItemAtIndexPath, binder), @"raise a block circle reference reason: sizeForItemAtIndexPath");
    
    /*Getting the Header and Footer Sizes*/
    NSAssert(!checkCircleReference(binder.layoutInsetForSectionAtIndex, binder), @"raise a block circle reference reason: layoutInsetForSectionAtIndex");
    NSAssert(!checkCircleReference(binder.minimumLineSpacingForSectionAtIndex, binder), @"raise a block circle reference reason: minimumLineSpacingForSectionAtIndex");
    NSAssert(!checkCircleReference(binder.minimumInteritemSpacingForSectionAtIndex, binder), @"raise a block circle reference reason: minimumInteritemSpacingForSectionAtIndex");
    
    /*Getting the Size of Items*/
    NSAssert(!checkCircleReference(binder.layoutReferenceSizeForHeaderInSection, binder), @"raise a block circle reference reason: layoutReferenceSizeForHeaderInSection");
    NSAssert(!checkCircleReference(binder.layoutReferenceSizeForFooterInSection, binder), @"raise a block circle reference reason: layoutReferenceSizeForFooterInSection");
    
    /* UICollecionView DataSource Prefectching 协议 block 形式*/
    NSAssert(!checkCircleReference(binder.prefetchItemsAtIndexPaths, binder), @"raise a block circle reference reason: prefetchItemsAtIndexPaths");
    NSAssert(!checkCircleReference(binder.cancelPrefetchingForItemsAtIndexPaths, binder), @"raise a block circle reference reason: cancelPrefetchingForItemsAtIndexPaths");
    
}
-(void)setDataSource:(NSArray *)dataSource{
    if (_dataSource != dataSource) {
        if ([_dataSource isKindOfClass:[NSMutableArray class]]) {
            [self removeDatasourceObserver];
        }
    }
    _dataSource  = dataSource;
    // 监视数组变化
    if ([self.dataSource isKindOfClass:[NSMutableArray class]]) {
        [self addObserverForDataSource:(NSMutableArray*)self.dataSource];
        if (_listener.collectionViewStyle ==UICollectionViewStyleGrouped) {
            for (NSMutableArray * arry in self.dataSource) {
                if ([arry isKindOfClass:[NSMutableArray class]]) {
                    [self addObserverForDataSource:arry];
                }
            }
        }
    }
}
-(void)removeDatasourceObserver{
    for (MutableArrayListener * observer in self.observerArray) {
        [ (NSMutableArray*)self.dataSource removeListener:observer];
        for (NSMutableArray * subarray in self.dataSource) {
            if ([subarray isKindOfClass:[NSMutableArray class]]) {
                [subarray removeListener:observer];
            }
        }
    }
    [self.observerArray removeAllObjects];
}

-(void)addObserverForDataSource:(NSMutableArray *)array{
    // 监视数组变化 一组数组与二维数组的变化
    MutableArrayListener * listener = [[MutableArrayListener alloc]init];
    
    typeof(self) __weak weakself = self;
    BOOL isGrouped = _listener.collectionViewStyle == UICollectionViewStyleGrouped;
    listener.didChanged = ^(NSMutableArray *array) {
        //数组改变
        if (array == weakself.dataSource) {
            [weakself.collectionView reloadData];
            [weakself removeDatasourceObserver];
            [weakself addObserverForDataSource:(NSMutableArray*)weakself.dataSource];
            for (NSMutableArray * subarray in weakself.dataSource) {
                if ([subarray isKindOfClass:[NSMutableArray class]]) {
                    [weakself addObserverForDataSource:subarray];
                }
            }
        }else{
            NSInteger section = [weakself.dataSource indexOfObjectIdenticalTo:array];
            [weakself.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
        }
    };
    
    listener.didAddObjects = ^(NSMutableArray *array, NSArray *objects, NSIndexSet *indexes) {
        //        数组加了多个元素
        if (array == weakself.dataSource) {
            if (isGrouped) {
                [weakself.collectionView insertSections:indexes];
                for (NSMutableArray * subArray in objects) {
                    if ([subArray isKindOfClass:[NSMutableArray class]]) {
                        [weakself addObserverForDataSource:subArray];
                    }
                }
            }else{
                NSMutableArray * indexPaths = [NSMutableArray array];
                [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                }];
                if (array.count == indexes.count) {
                    [weakself.collectionView reloadData];
                } else {
                    [weakself.collectionView insertItemsAtIndexPaths:indexPaths];
                }
            }
        }else{
            NSInteger section = [weakself.dataSource indexOfObjectIdenticalTo:array];
            NSMutableArray * indexPaths = [NSMutableArray array];
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
            }];
            if (array.count == indexes.count) {
                [weakself.collectionView reloadData];
            } else {
                [weakself.collectionView insertItemsAtIndexPaths:indexPaths];
            }
        }
    };
    
    listener.didDeleteObjects = ^(NSMutableArray *array, NSArray *objects, NSIndexSet *indexes) {
        //        数组删除了多个元素
        if (array == weakself.dataSource) {
            if (isGrouped) {
                [weakself.collectionView deleteSections:indexes];
            }else{
                NSMutableArray * indexPaths = [NSMutableArray array];
                [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                }];
                [weakself.collectionView deleteItemsAtIndexPaths:indexPaths];
            }
        }else{
            NSInteger section = [weakself.dataSource indexOfObjectIdenticalTo:array];
            NSMutableArray * indexPaths = [NSMutableArray array];
            [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
            }];
            [weakself.collectionView deleteItemsAtIndexPaths:indexPaths];
        }
    };
    listener.didReplaceObject = ^(NSMutableArray *array, id anObject, id withObject, NSUInteger index) {
        //        数组中一个元素替换了
        if (array == weakself.dataSource) {
            if (isGrouped) {
                [weakself.collectionView reloadSections:[NSIndexSet indexSetWithIndex:index]];
                if ([withObject isKindOfClass:[NSMutableArray class]]) {
                    [weakself addObserverForDataSource:withObject];
                }
            }else{
                [weakself.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
            }
        }else{
            NSInteger section = [weakself.dataSource indexOfObjectIdenticalTo:array];
            [weakself.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:section]]];
        }
    };
    listener.didExchangeIndex = ^(NSMutableArray *array, NSUInteger index1, NSUInteger index2) {
        //        数组中元素交换了位置
        if (array == weakself.dataSource) {
            if (isGrouped) {
                [weakself.collectionView performBatchUpdates:^{
                    [weakself.collectionView moveSection:index1 toSection:index2];
                    [weakself.collectionView moveSection:index2 toSection:index1];
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                [weakself.collectionView performBatchUpdates:^{
                    [weakself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:index1 inSection:0] toIndexPath:[NSIndexPath  indexPathForItem:index2 inSection:0]];
                    [weakself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:index2 inSection:0] toIndexPath:[NSIndexPath  indexPathForItem:index1 inSection:0]];
                } completion:^(BOOL finished) {
                    
                }];
                
            }
        }else{
            NSInteger section = [weakself.dataSource indexOfObjectIdenticalTo:array];
            [weakself.collectionView performBatchUpdates:^{
                [weakself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:index1 inSection:section] toIndexPath:[NSIndexPath  indexPathForItem:index2 inSection:section]];
                [weakself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:index2 inSection:section] toIndexPath:[NSIndexPath  indexPathForItem:index1 inSection:section]];
            } completion:^(BOOL finished) {
                
            }];
        }
    };
    [array addListener:listener];
    [self.observerArray addObject:listener];
}



#pragma mark  - CollectionView DataSource  require
/* CollectionView DataSource 协议 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        return _dataSource.count;
    }else{
        return [_dataSource[section] count];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_listener.collectionViewStyle == UICollectionViewStylePlain) {
        return 1;
    }else{
        return _dataSource.count;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSAssert(self.listener.cellForItemAtIndexPath, @"cellForItemAtIndexPath block must not be nil");
    id object = nil;
    if (_listener.collectionViewStyle == UICollectionViewStylePlain){
        object = _dataSource[indexPath.row];
    }else{
        object = _dataSource[indexPath.section][indexPath.row];
        
    }
    return self.listener.cellForItemAtIndexPath(collectionView,indexPath,object);
}

#pragma mark - UIScrollView Delegate
// any offset changes
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_listener.scrollViewDidScroll) {
        _listener.scrollViewDidScroll(scrollView);
    }
}
// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2){
    
    if(_listener.scrollViewDidZoom){
        _listener.scrollViewDidZoom(scrollView);
    }
}


// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_listener.scrollViewWillBeginDragging) {
        _listener.scrollViewWillBeginDragging(scrollView);
    }
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    
    if(_listener.scrollViewWillEndDragging){
        _listener.scrollViewWillEndDragging(scrollView, velocity, targetContentOffset);
    }
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (_listener.scrollViewDidEndDragging) {
        _listener.scrollViewDidEndDragging(scrollView, decelerate);
    }
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (_listener.scrollViewWillBeginDecelerating) {
        _listener.scrollViewWillBeginDecelerating(scrollView);
    }
}
// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_listener.scrollViewDidEndDecelerating) {
        _listener.scrollViewDidEndDecelerating(scrollView);
    }
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_listener.scrollViewDidEndScrollingAnimation) {
        _listener.scrollViewDidEndScrollingAnimation(scrollView);
    }
}

 // return a view that will be scaled. if delegate returns nil, nothing happens
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (_listener.viewForZoomingInScrollView) {
        return _listener.viewForZoomingInScrollView(scrollView);
    }
    return nil;
}
// called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2){
    if (_listener.scrollViewWillBeginZooming){
        _listener.scrollViewWillBeginZooming(scrollView, view);
    }
}
// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    if (_listener.scrollViewDidEndZooming) {
        _listener.scrollViewDidEndZooming(scrollView, view, scale);
    }
}
// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if (_listener.scrollViewShouldScrollToTop) {
        return _listener.scrollViewShouldScrollToTop(scrollView);
    }
    return YES;
}
// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if (_listener.scrollViewShouldScrollToTop) {
        _listener.scrollViewShouldScrollToTop(scrollView);
    }
}

/* Also see -[UIScrollView adjustedContentInsetDidChange]
 */
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)){
    if(_listener.scrollViewDidChangeAdjustedContentInset){
        _listener.scrollViewDidChangeAdjustedContentInset(scrollView);
    }
}
@end
