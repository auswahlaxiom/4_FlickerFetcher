//
//  PhotoScrollViewController.m
//  4_FlickerFetcher
//
//  Created by Zachary Fleischman on 3/2/13.
//  Copyright (c) 2013 Zachary Fleischman. All rights reserved.
//

#import "PhotoScrollViewController.h"
#import "FlickrFetcher.h"

@interface PhotoScrollViewController () <UIScrollViewDelegate>

@end

@implementation PhotoScrollViewController
@synthesize scrollView;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *photoURL = [FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatOriginal];
    NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
    UIImage *photoImage = [UIImage imageWithData:photoData];
    self.imageView.image = photoImage;
    
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
    self.scrollView.contentSize = self.imageView.image.size;
   
    
    CGFloat vScale = self.imageView.bounds.size.height / self.scrollView.bounds.size.height;
    CGFloat hScale = self.imageView.bounds.size.width / self.scrollView.bounds.size.width;
    
    //adjust min/max zoom scales for image if neccessary
    if(MIN(vScale, hScale) < self.scrollView.minimumZoomScale) self.scrollView.minimumZoomScale = MIN(vScale, hScale);
    if(MAX(vScale, hScale) > self.scrollView.maximumZoomScale) self.scrollView.maximumZoomScale = MAX(vScale, hScale);
    
    //initial zoom state such that there are no blank bars, and the image is as big as possible while still all fitting in
    if(vScale > hScale) {
        self.scrollView.zoomScale = 1/hScale;
    } else {
        self.scrollView.zoomScale = 1/vScale;
    }
    

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


@end
