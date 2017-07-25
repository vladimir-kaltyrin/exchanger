#import "ExchangeMoneyCurrencyViewController.h"
#import "ExchangeMoneyCurrencyView.h"
#import "ExchangeMoneyCurrencyViewData.h"

@interface ExchangeMoneyCurrencyViewController ()
@property (nonatomic, strong) ExchangeMoneyCurrencyViewData *viewData;
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
    }
    return self;
}

// MARK: - ViewController life-cycle

- (void)loadView {
    ExchangeMoneyCurrencyView *view = [[ExchangeMoneyCurrencyView alloc] init];
    [view setViewData:self.viewData];
    
    self.view = view;
}

// MARK: - ExchangeMoneyCurrencyViewController

- (NSInteger)pageIndex {
    return self.pageIndex;
}

@end
