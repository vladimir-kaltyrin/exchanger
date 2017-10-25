#import "ExchangeMoneyView.h"
#import "ExchangeMoneyPageViewController.h"
#import "KeyboardObserverImpl.h"
#import "ExchangeMoneyCurrencyViewData.h"
#import "GalleryPreviewData.h"
#import "GalleryPreviewPageData.h"
#import "KeyboardData.h"
#import "CurrencyRateCell.h"
#import "UIView+Properties.h"

NSString * const kCurrencyRateCellId = @"kCurrencyRateCellId";

@interface ExchangeMoneyView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@end

@implementation ExchangeMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[CurrencyRateCell class] forCellReuseIdentifier:kCurrencyRateCellId];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [self addSubview:self.tableView];
        [self addSubview:self.activityIndicator];
    }
    
    return self;
}

// MARK: - ExchangeMoneyView

- (void)focusOnStart {
    
}

- (void)updateKeyboardData:(KeyboardData *)keyboardData {
    self.keyboardHeight = keyboardData.size.height;
    [self setNeedsLayout];
}

- (void)setSourceCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    
}

- (void)setTargetCurrencyViewData:(NSArray<ExchangeMoneyCurrencyViewData *> *)viewData {
    
}

- (void)startActivity {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivity {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

// MARK: - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.activityIndicator.center = self.center;
    self.tableView.frame = self.bounds;
}
    
// MARK: - UITableViewDelegate
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
    
// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyRateCell *cell = (CurrencyRateCell *)[tableView dequeueReusableCellWithIdentifier:kCurrencyRateCellId];
    if (cell == nil) {
        cell = [[CurrencyRateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCurrencyRateCellId];
    }
    
    GalleryPreviewPageData *page1 = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:@"title1"
                                                                         currencyAmount:@"amount1"
                                                                              remainder:@"remainder1"
                                                                                   rate:@"rate1"];
    
    GalleryPreviewPageData *page2 = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:@"title2"
                                                                         currencyAmount:@"amount2"
                                                                              remainder:@"remainder2"
                                                                                   rate:@"rate2"];
    
    GalleryPreviewPageData *page3 = [[GalleryPreviewPageData alloc] initWithCurrencyTitle:@"title3"
                                                                         currencyAmount:@"amount3"
                                                                              remainder:@"remainder3"
                                                                                   rate:@"rate3"];
    
    GalleryPreviewData *data = [[GalleryPreviewData alloc] initWithPages:@[page1, page2, page3] onTap:^{
        NSLog(@"Tap");
    }];
    
    [cell updateWithModel:data];
    
    return cell;
}

@end
