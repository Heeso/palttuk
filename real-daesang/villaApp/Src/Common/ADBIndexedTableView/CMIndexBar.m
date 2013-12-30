//
//  CMIndexBar.m
//
//  Created by Craig Merchant on 07/04/2011.
//

#import "CMIndexBar.h"

#import <QuartzCore/QuartzCore.h>

@interface CMIndexBar ()
@property(nonatomic, strong) UITableView* tableView;

- (void)initializeDefaults;

@end


const CGFloat kIndexViewWidth = 20;
@implementation CMIndexBar

@synthesize delegate;
@synthesize highlightedBackgroundColor;
@synthesize textColor;

- (id)init {
	if ((self = [super init])) {
        [self initializeDefaults];
	}
    
	return self;
}

- (id)initWithTableView:(UITableView*)tableView{
    // 인덱스뷰가 필요 없어 보인다
    CGRect selfFrame = tableView.frame;
    selfFrame.origin.x = CGRectGetMaxX(tableView.frame) - kIndexViewWidth;
    selfFrame.size.width = kIndexViewWidth;
    if ((self = [super initWithFrame:selfFrame]))  {
        [self initializeDefaults];
        self.tableView = tableView;
        [tableView.superview addSubview:self];
    }
    
    return self;
}

- (void)initializeDefaults {
    // Default colors.
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor grayColor];
//    if(IS_OVER_IOS7()){
//        self.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
//    }
    
    self.highlightedBackgroundColor = [UIColor lightGrayColor];

    // HelveticaNeue Bold 11pt is a font of native table index
    self.textFont = [UIFont fontWithName: @"HelveticaNeue-Bold" size: 11];
}

- (void)layoutSubviews 
{
	[super layoutSubviews];	

	int i=0;
	int subcount=0;
	
	for (UIView *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			subcount++;
		}
	}
	
	for (UIView *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
//			float ypos;
//			
//			if(i == 0)
//			{
//				ypos = 0;
//			}
//			else if(i == subcount-1)
//			{
//				ypos = self.frame.size.height-24.0;
//			}
//			else
//			{
//				float sectionheight = ((self.frame.size.height-24.0)/subcount);
//				
//				sectionheight = sectionheight+(sectionheight/subcount);
//				
//				ypos = (sectionheight*i);
//			}

            CGFloat yPos = i * self.frame.size.height / [self.subviews count];
			[subview setFrame:CGRectMake(0, yPos, self.frame.size.width, 24.0)];
			
			i++;
		}
	}
}

- (void) setIndexes:(NSArray*)indexes
{	
	[self clearIndex];
	
	int i;

	NSInteger count = [indexes count];
	for (i=0; i<count; i++)
	{
		CGFloat yPos = i * self.frame.size.height / count;


//		if(i == 0)
//		{
//			ypos = 0;
//		}
//		else if(i == [indexes count]-1)
//		{
//			ypos = self.frame.size.height-24.0;
//		}
//		else
//		{
//			float sectionheight = ((self.frame.size.height-24.0)/[indexes count]);			
//			sectionheight = sectionheight+(sectionheight/[indexes count]);
//			
//			ypos = (sectionheight*i);
//		}
		
		UILabel *alphaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, self.frame.size.width, 24.0)];
		alphaLabel.textAlignment = NSTextAlignmentCenter;
		alphaLabel.text = [indexes objectAtIndex:i];
		alphaLabel.font = self.textFont;
		alphaLabel.backgroundColor = [UIColor clearColor];
		alphaLabel.textColor = textColor;
		[self addSubview:alphaLabel];	
	}
    
    [self.tableView reloadData];
    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
        [self removeFromSuperview];
    }

}

- (void) clearIndex
{
	for (UIView *subview in self.subviews) 
	{
		[subview removeFromSuperview];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
  [self touchesEndedOrCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesCancelled:touches withEvent:event];
  [self touchesEndedOrCancelled:touches withEvent:event];
}

- (void) touchesEndedOrCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
 	UIView *backgroundView = (UIView*)[self viewWithTag:767];
	[backgroundView removeFromSuperview];
    for (UIGestureRecognizer *gesture in self.superview.gestureRecognizers){
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]){
            gesture.cancelsTouchesInView = YES;
        }
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	
	UIView *backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.bounds.size.width, self.bounds.size.height)];
	[backgroundview setBackgroundColor:highlightedBackgroundColor];
	backgroundview.layer.cornerRadius = self.bounds.size.width/2;
	backgroundview.layer.masksToBounds = YES;
	backgroundview.tag = 767;
	[self addSubview:backgroundview];
	[self sendSubviewToBack:backgroundview];
    

    // 인덱스 바내에서 스크롤하게 되면
    // NaviVewController의 panGuesture가 이벤트를 받아서 처리해서
    // touchesCancelled가 호출되어 버려 하위 뷰에서 touchMoved 이벤트를 받을 수 없게 된다
    // 그래서 터치할경우에 cancelTouch가 일어나지 않도록 처리하고
    // 이 뷰안에서 터치를 뗄경우에는 다시 YES로 처리한다
    for (UIGestureRecognizer *gesture in self.superview.gestureRecognizers){
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]){
            gesture.cancelsTouchesInView = NO;
        }
    }
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];

	if(touchPoint.x < 0)
	{
		return;
	}
	
	NSString *title = nil;
	int count=0;
	
	for (UILabel *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			if(touchPoint.y < subview.frame.origin.y+subview.frame.size.height)
			{
				count++;
				title = subview.text;
				break;
			}
			
			count++;
			title = subview.text;
		}
	}
    
    [self defaultIndexSelectionDidChange:(count-1) title:title];
    
	NSLog(@"%@, %@", NSStringFromCGPoint(touchPoint), title);
    if (!self.delegate)
        return;
    
    if ([delegate respondsToSelector: @selector(indexSelectionDidChange:index:title:)])
        [delegate indexSelectionDidChange: self index: count - 1 title: title];
}

- (void)defaultIndexSelectionDidChange:(NSInteger)index title:(NSString*)title{
    NSInteger countForIndex = 0;
    for(NSInteger idx=0;idx<index;idx++){
        countForIndex += [self.tableView numberOfRowsInSection:idx];
    }

    CGFloat cellHeight = 44;
    if (self.cellHeight > 0) {
        cellHeight = self.cellHeight;
    }

    CGFloat yPosOffset = countForIndex * cellHeight;
    CGFloat maxOffset = self.tableView.contentSize.height - self.tableView.frame.size.height;
    
    // 이동할 위치가 contentSize를 넘어가서
    // 하단에 공백이 보이지 않도록 처리
    if (maxOffset > 0 && yPosOffset > maxOffset) {
        yPosOffset = maxOffset;
    }
    CGPoint contentOffset = CGPointMake(0, yPosOffset);
    self.tableView.contentOffset = contentOffset;

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
	
	if(touchPoint.x < 0)
	{
		return;
	}
	
	NSString *title = nil;
	int count=0;
	
	for (UILabel *subview in self.subviews) 
	{
		if ([subview isKindOfClass:[UILabel class]]) 
		{
			if(touchPoint.y < subview.frame.origin.y+subview.frame.size.height)
			{
				count++;
				title = subview.text;
				break;
			}
			
			count++;
			title = subview.text;
		}
	}
    
    [self defaultIndexSelectionDidChange:(count-1) title:title];

    if (!self.delegate)
        return;

    if ([delegate respondsToSelector: @selector(indexSelectionDidChange:index:title:)])
        [delegate indexSelectionDidChange: self index: count - 1 title: title];
}

@end
