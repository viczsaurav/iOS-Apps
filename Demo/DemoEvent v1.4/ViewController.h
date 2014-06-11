#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;


@property (nonatomic, strong) IBOutlet UIImageView *firstPieceView;

-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIImageView *)theView;
-(void)animateView:(UIView *)theView toPosition:(CGPoint) thePosition;
@end
