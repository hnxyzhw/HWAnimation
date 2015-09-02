//
//  CollectionViewController.m
//  Animation
//
//  Created by Marvin on 15/9/1.
//  Copyright (c) 2015年 Marvin. All rights reserved.
//

#import "CollectionViewController.h"

#import "Cell.h"

@interface CollectionViewController ()<UIScrollViewDelegate>
{
    UIButton *button;
    NSInteger selectItem;
}
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor orangeColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    button = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width  - 90) / 2, (self.view.frame.size.height - 90 ), 90, 90)];
    button.layer.masksToBounds =  YES;
    button.layer.cornerRadius = button.frame.size.width / 2;
    button.backgroundColor = [UIColor clearColor];
//    button.layer.shadowOffset = CGSizeMake(10, 10);
//    button.layer.shadowColor = [[UIColor redColor] CGColor];
//    button.layer.shadowOpacity = 1.0;
    button.clipsToBounds = NO;
    
    button.layer.borderColor = [[UIColor redColor] CGColor];
    
    button.layer.borderWidth = 2.0f;
    
    
    [button addTarget:self action:@selector(playBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIImageView *btnContentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    btnContentImageView.center = CGPointMake(button.frame.size.width / 2, button.frame.size.height / 2);
    btnContentImageView.backgroundColor = [UIColor redColor];
    btnContentImageView.userInteractionEnabled = NO;
    btnContentImageView.alpha = 0.5;
    btnContentImageView.layer.cornerRadius = btnContentImageView.frame.size.width / 2;
    btnContentImageView.layer.masksToBounds = YES;
    btnContentImageView.tag = 1111;
    [button addSubview:btnContentImageView];
    
    UILabel *btnContentLabel = [[UILabel alloc]initWithFrame:button.bounds];
    btnContentLabel.text = @"Start";
    btnContentLabel.textColor = [UIColor whiteColor];
    btnContentLabel.font = [UIFont systemFontOfSize:15.0];
    btnContentLabel.textAlignment = NSTextAlignmentCenter;
    
    btnContentLabel.tag = 2222;
    btnContentLabel.hidden = YES;
    [button addSubview:btnContentLabel];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return 25;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    
    return cell;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectItem = indexPath.item;
    NSLog(@"%ld",selectItem);
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    UIImageView *btnContentView = (UIImageView *)[button viewWithTag:1111];
    btnContentView.hidden = YES;
    UILabel *btnContentLabel = (UILabel *)[button viewWithTag:2222];
    btnContentLabel.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
//    NSLog(@"contectoffset.x:%f",scrollView.contentOffset.x);
    
    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
    UIImageView *btnContentView = (UIImageView *)[button viewWithTag:1111];
    btnContentView.hidden = NO;
    
    
    selectItem = scrollView.contentOffset.x / 75;
    NSLog(@"-----%ld",selectItem);
    
}

-(void)playBtn{
    NSLog(@"doSomeThings by select Item:%ld",selectItem);
    
    UILabel *btnContentLabel = (UILabel *)[button viewWithTag:2222];
    btnContentLabel.hidden = NO;
    
    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
}


@end
