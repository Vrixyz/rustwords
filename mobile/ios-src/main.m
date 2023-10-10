#include <stdio.h>

#import "bindings.h"

int main() {
    main_rs();
    return 0;
}

void display_ad(UIWindow* window, UIViewController* viewController) {
   NSLog( @"super my print" );
}
