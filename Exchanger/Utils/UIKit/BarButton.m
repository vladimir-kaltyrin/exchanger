#import "BarButton.h"
#import "ConvenientObjC.h"

@interface BarButton()
@property (nonatomic, strong) UIBarButtonItem *barButtonItem;
@end

@implementation BarButton

// MARK: - Init

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(onBarButtonTap:)];
    }
    return self;
}

// MARK: - Public

- (void)setEnabled:(BOOL)enabled {
    self.barButtonItem.enabled = enabled;
}

- (BOOL)enabled {
    return self.barButtonItem.enabled;
}

- (void)setAccessibilityIdentifier:(NSString *)accessibilityIdentifier {
    self.barButtonItem.accessibilityIdentifier = accessibilityIdentifier;
}

- (NSString *)accessibilityIdentifier {
    return self.barButtonItem.accessibilityIdentifier;
}

// MARK: - Private

- (void)onBarButtonTap:(id)sender {
    safeBlock(self.onBarButtonTap);
}

@end
