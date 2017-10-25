#import "ExchangeMoneyCurrencyViewController.h"
#import "ExchangeMoneyCurrencyView.h"
#import "ExchangeMoneyCurrencyViewData.h"

@interface ExchangeMoneyCurrencyViewController ()
@property (nonatomic, strong) ExchangeMoneyCurrencyViewData *viewData;
@property (nonatomic, strong) ExchangeMoneyCurrencyView* currencyView;
@property (nonatomic) NSInteger pageIndex;
@end

@implementation ExchangeMoneyCurrencyViewController

// MARK: - Init

- (instancetype)initWithViewData:(ExchangeMoneyCurrencyViewData *)viewData
                           index:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewData = viewData;
        self.pageIndex = pageIndex;
        
        self.currencyView = [[ExchangeMoneyCurrencyView alloc] init];
        
    }
    return self;
}

// MARK: - ViewController life-cycle

- (void)loadView {
    [self.currencyView setViewData:self.viewData];
    
    self.view = self.currencyView;
}

// MARK: - FirstResponder

- (BOOL)becomeFirstResponder {
    return [self.currencyView becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.currencyView resignFirstResponder];
}

//
//- (BOOL)isFirstResponder {
//    return [self.currencyView isFirstResponder];
//}

@end
