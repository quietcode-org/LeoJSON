#import <Foundation/Foundation.h>
#import "LeoJSON.h"

static int gFailures = 0;

static void pass(const char *name)
{
    printf("PASS: %s\n", name);
}

static void fail(const char *name, NSString *message)
{
    gFailures++;
    fprintf(stderr, "FAIL: %s", name);

    if (message != nil) {
        fprintf(stderr, " -- %s", [message UTF8String]);
    }

    fprintf(stderr, "\n");
}

static void expectNilObject(const char *name, id object, NSString *errorString)
{
    if (object == nil && errorString != nil) {
        pass(name);
    } else {
        fail(name, errorString);
    }
}

static void expectNilData(const char *name, NSData *data, NSString *errorString)
{
    if (data == nil && errorString != nil) {
        pass(name);
    } else {
        fail(name, errorString);
    }
}

static void testNilData(void)
{
    NSString *errorString = nil;
    id object = LeoJSONObjectFromData(nil, LeoJSONReadStrict, &errorString);
    expectNilObject("nil data fails with error string", object, errorString);
}

static void testEmptyData(void)
{
    NSString *errorString = nil;
    NSData *data = [NSData data];
    id object = LeoJSONObjectFromData(data, LeoJSONReadStrict, &errorString);
    expectNilObject("empty data fails with error string", object, errorString);
}

static void testInvalidJSON(void)
{
    NSString *errorString = nil;
    NSData *data = [@"{\"broken\":" dataUsingEncoding:NSUTF8StringEncoding];
    id object = LeoJSONObjectFromData(data, LeoJSONReadStrict, &errorString);
    expectNilObject("invalid JSON fails with error string", object, errorString);
}

static void testUnsupportedReadOption(void)
{
    NSString *errorString = nil;
    NSData *data = [@"{\"ok\":true}" dataUsingEncoding:NSUTF8StringEncoding];

    id object = LeoJSONObjectFromData(data, (LeoJSONReadOptions)999, &errorString);
    expectNilObject("unsupported read option fails with error string", object, errorString);
}

static void testNilObject(void)
{
    NSString *errorString = nil;
    NSData *data = LeoJSONDataFromObject(nil, LeoJSONWriteCompact, &errorString);
    expectNilData("nil object fails with error string", data, errorString);
}

static void testUnsupportedWriteOption(void)
{
    NSString *errorString = nil;
    NSDictionary *object = [NSDictionary dictionaryWithObject:@"LeoJSON" forKey:@"name"];

    NSData *data = LeoJSONDataFromObject(object, (LeoJSONWriteOptions)999, &errorString);
    expectNilData("unsupported write option fails with error string", data, errorString);
}

static void testNonSerializableObject(void)
{
    NSString *errorString = nil;
    NSDate *date = [NSDate date];

    NSData *data = LeoJSONDataFromObject(date, LeoJSONWriteCompact, &errorString);
    expectNilData("non-serializable object fails with error string", data, errorString);
}

static void testNullErrorPointerParse(void)
{
    NSData *data = [@"{\"broken\":" dataUsingEncoding:NSUTF8StringEncoding];
    id object = LeoJSONObjectFromData(data, LeoJSONReadStrict, NULL);

    if (object == nil) {
        pass("parse failure tolerates NULL error pointer");
    } else {
        fail("parse failure tolerates NULL error pointer", nil);
    }
}

static void testNullErrorPointerWrite(void)
{
    NSData *data = LeoJSONDataFromObject(nil, LeoJSONWriteCompact, NULL);

    if (data == nil) {
        pass("write failure tolerates NULL error pointer");
    } else {
        fail("write failure tolerates NULL error pointer", nil);
    }
}

static void testSuccessClearsError(void)
{
    NSString *errorString = @"old error";
    NSData *data = [@"{\"ok\":true}" dataUsingEncoding:NSUTF8StringEncoding];

    id object = LeoJSONObjectFromData(data, LeoJSONReadStrict, &errorString);

    if (object != nil && errorString == nil) {
        pass("successful parse clears error string");
    } else {
        fail("successful parse clears error string", errorString);
    }
}

int main(int argc, const char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    testNilData();
    testEmptyData();
    testInvalidJSON();
    testUnsupportedReadOption();
    testNilObject();
    testUnsupportedWriteOption();
    testNonSerializableObject();
    testNullErrorPointerParse();
    testNullErrorPointerWrite();
    testSuccessClearsError();

    if (gFailures == 0) {
        printf("OK: LeoJSON error smoke probe passed\n");
    } else {
        fprintf(stderr, "FAIL: LeoJSON error smoke probe failed with %d failure(s)\n", gFailures);
    }

    [pool drain];

    return (gFailures == 0) ? 0 : 1;
}
