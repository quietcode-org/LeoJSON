#import <Foundation/Foundation.h>
#import "LeoJSON.h"

static int fail(NSString *message)
{
    fprintf(stderr, "FAIL: %s\n", [message UTF8String]);
    return 1;
}

int main(int argc, const char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSString *jsonString =
        @"{"
         "\"name\":\"LeoJSON\","
         "\"purpose\":\"Leopard-Crew JSON boundary\","
         "\"unicode\":\"Grüße vom G5\","
         "\"values\":[1,2,3]"
        "}";

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSString *errorString = nil;
    id object = LeoJSONObjectFromData(jsonData, LeoJSONReadStrict, &errorString);

    if (object == nil) {
        int result = fail(errorString ? errorString : @"parse failed");
        [pool drain];
        return result;
    }

    if (![object isKindOfClass:[NSDictionary class]]) {
        int result = fail(@"parsed root object is not an NSDictionary");
        [pool drain];
        return result;
    }

    NSData *roundtrip = LeoJSONDataFromObject(object, LeoJSONWriteCompact, &errorString);

    if (roundtrip == nil) {
        int result = fail(errorString ? errorString : @"serialization failed");
        [pool drain];
        return result;
    }

    NSString *roundtripString =
        [[NSString alloc] initWithData:roundtrip encoding:NSUTF8StringEncoding];

    printf("OK: LeoJSON API smoke probe passed\n");
    printf("Roundtrip JSON: %s\n", [roundtripString UTF8String]);

    [roundtripString release];
    [pool drain];

    return 0;
}
