//
//  DZMultilevelMenu.m
//  JD-Mobile
//
//  Created by dengwei on 16/2/23.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "DZMultilevelMenu.h"
#import "DZMultilevelTableViewCell.h"
#import "DZMultilevelCollectionViewCell.h"
#import "DZCategoryMenuModel.h"
#import "UIImageView+WebCache.h"

#define kLeftWidth 100
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"DZMultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"DZCollectionHeader"//CollectionHeader
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DZMultilevelMenu()

@property(strong,nonatomic ) UITableView *leftTablew;
@property(strong,nonatomic ) UICollectionView *rightCollection;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@end

@implementation DZMultilevelMenu

-(id)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex {
    if (self  == [super initWithFrame:frame]) {
        if (data.count == 0) {
            return nil;
        }
        
        _block = selectIndex;
        self.leftSelectColor = [UIColor blackColor];
        self.leftSelectBgColor = [UIColor whiteColor];
        self.leftBgColor = UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor = UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor = UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor = [UIColor blackColor];
        
        _selectIndex = 0;
        _allData = data;
        
        /**
         左边的视图
         */
        self.leftTablew = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource = self;
        self.leftTablew.delegate = self;
        
        self.leftTablew.tableFooterView = [[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor = self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins = UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset = UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor = self.leftSeparatorColor;
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0.f;//左右间隔
        flowLayout.minimumLineSpacing = 0.f;
        float leftMargin = 0;
        self.rightCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,64,kScreenWidth-kLeftWidth-leftMargin*2,frame.size.height-64) collectionViewLayout:flowLayout];
        
        self.rightCollection.delegate = self;
        self.rightCollection.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
        
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        UINib *header = [UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
        [self.rightCollection registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        
        [self addSubview:self.rightCollection];
        
        self.isReturnLastOffset = YES;
        
        self.rightCollection.backgroundColor = self.leftSelectBgColor;
        
        self.backgroundColor = self.leftSelectBgColor;
    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    if (needToScorllerIndex > 0) {
        
        /**
         *  滑动到 指定行数
         */
        [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        DZMultilevelTableViewCell *cell = (DZMultilevelTableViewCell *)[self.leftTablew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0]];
        UILabel *line = (UILabel *)[cell viewWithTag:100];
        line.backgroundColor = cell.backgroundColor;
        cell.title.textColor = self.leftSelectColor;
        cell.backgroundColor = self.leftSelectBgColor;
        _selectIndex = needToScorllerIndex;
        
        [self.rightCollection reloadData];
    }
    _needToScorllerIndex = needToScorllerIndex;
}

-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor = leftBgColor;
    self.leftTablew.backgroundColor = leftBgColor;
}

-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    _leftSelectBgColor = leftSelectBgColor;
    self.rightCollection.backgroundColor = leftSelectBgColor;
    self.backgroundColor = leftSelectBgColor;
}

-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor = leftSeparatorColor;
    self.leftTablew.separatorColor = leftSeparatorColor;
}

-(void)reloadData{
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
}

#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark--dcollectionView里有多少个组
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Identifier = @"MultilevelTableViewCell";
    DZMultilevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DZMultilevelTableViewCell" owner:self options:nil][0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor = tableView.separatorColor;
        [cell addSubview:label];
        label.tag = 100;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DZCategoryMenuModel *title = self.allData[indexPath.row];
    
    cell.title.text = title.menuName;
    
    UILabel *line = (UILabel *)[cell viewWithTag:100];
    if (indexPath.row == self.selectIndex) {
        cell.title.textColor = self.leftSelectColor;
        cell.backgroundColor = self.leftSelectBgColor;
        line.backgroundColor = cell.backgroundColor;
    }else{
        cell.title.textColor = self.leftUnSelectColor;
        cell.backgroundColor = self.leftUnSelectBgColor;
        line.backgroundColor = tableView.separatorColor;
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DZMultilevelTableViewCell *cell = (DZMultilevelTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = self.leftSelectColor;
    cell.backgroundColor = self.leftSelectBgColor;
    _selectIndex = indexPath.row;
    DZCategoryMenuModel *title = self.allData[indexPath.row];
    UILabel *line = (UILabel *)[cell viewWithTag:100];
    line.backgroundColor = cell.backgroundColor;
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset = NO;
    [self.rightCollection reloadData];
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }else{
        [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    DZMultilevelTableViewCell *cell = (DZMultilevelTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = self.leftUnSelectColor;
    UILabel *line = (UILabel *)[cell viewWithTag:100];
    line.backgroundColor = tableView.separatorColor;
    
    cell.backgroundColor = self.leftUnSelectBgColor;
}

#pragma mark - imageCollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.allData.count == 0) {
        return 0;
    }
    
    DZCategoryMenuModel *title = self.allData[self.selectIndex];
    return title.nextArray.count;
}

#pragma mark 每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    DZCategoryMenuModel *title = self.allData[self.selectIndex];
    
    if (title.nextArray.count > 0) {
        DZCategoryMenuModel *sub = title.nextArray[section];
        
        if (sub.nextArray.count == 0){//没有下一级
            return 1;
        }else{
            return sub.nextArray.count;
        }
    }else{
        return title.nextArray.count;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DZCategoryMenuModel *title = self.allData[self.selectIndex];
    DZCategoryMenuModel *menu = title.nextArray[indexPath.section];
    
    if (menu.nextArray.count > 0) {
        menu = title.nextArray[indexPath.section];
        NSArray *list = menu.nextArray;
        menu = list[indexPath.row];
    }
    
    void (^select)(NSInteger left,NSInteger right,id info) = self.block;
    select(self.selectIndex,indexPath.row,menu);
}

#pragma mark 定义并返回每个cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DZMultilevelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    DZCategoryMenuModel *title = self.allData[self.selectIndex];
    DZCategoryMenuModel *menu = title.nextArray[indexPath.section];
    
    if (menu.nextArray.count > 0) {
        menu = title.nextArray[indexPath.section];
        NSArray *list = menu.nextArray;
        menu = list[indexPath.row];
    }
    
    cell.title.text = menu.menuName;
    cell.backgroundColor = [UIColor clearColor];
    cell.imageView.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:menu.urlName];
    //给一张默认图片，先使用默认图片，当图片加载完成后再替换
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:menu.urlName]
                      placeholderImage:[UIImage imageNamed:menu.urlName]];
    return cell;
}

#pragma mark 定义并返回每个headerView或footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"footer";
    }else{
        reuseIdentifier = kMultilevelCollectionHeader;
    }
    
    DZCategoryMenuModel *title = self.allData[self.selectIndex];
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[view viewWithTag:1];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (title.nextArray.count > 0) {
            DZCategoryMenuModel *menu = title.nextArray[indexPath.section];
            label.text = menu.menuName;
        }else{
            label.text=@"暂无";
        }
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是footer:%ld",(long)indexPath.section];
    }
    
    return view;
}

#pragma mark - UICollectionViewDelegateFlowLayout 是UICollectionViewDelegate的子协议
#pragma mark 每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 90);
}

#pragma mark 设置每组的cell的边界, 具体看下图
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

#pragma mark cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {kScreenWidth,44};
    return size;
}

#pragma mark 记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.rightCollection]) {
        self.isReturnLastOffset = YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isEqual:self.rightCollection]) {
        DZCategoryMenuModel *title = self.allData[self.selectIndex];
        title.offsetScorller = scrollView.contentOffset.y;
        self.isReturnLastOffset = NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        DZCategoryMenuModel *title = self.allData[self.selectIndex];
        title.offsetScorller = scrollView.contentOffset.y;
        self.isReturnLastOffset = NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
        DZCategoryMenuModel *title = self.allData[self.selectIndex];
        title.offsetScorller = scrollView.contentOffset.y;
    }
}

#pragma mark - Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
