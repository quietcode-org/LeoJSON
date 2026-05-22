#import "LeoJSON.h"
#import "JSONKit.h"

static void LeoJSONSetError(NSString **errorString, NSString *message)
{
    if (errorString != NULL) {
        *errorString = message;
    }
}

id LeoJSONObjectFromData(NSData *data,
                         LeoJSONReadOptions options,
                         NSString **errorString)
{
    if (errorString != NULL) {
        *errorString = nil;
    }

    if (data == nil) {
        LeoJSONSetError(errorString, @"LeoJSON: input data is nil");
        return nil;
    }

    if (options != LeoJSONReadStrict) {
        LeoJSONSetError(errorString, @"LeoJSON: unsupported read option");
        return nil;
    }

    NSError *jsonKitError = nil;
    id object = [data objectFromJSONDataWithParseOptions:JKParseOptionStrict
                                                   error:&jsonKitError];

    if (object == nil) {
        NSString *message = @"LeoJSON: JSON parse failed";

        if (jsonKitError != nil) {
            message = [NSString stringWithFormat:@"LeoJSON: JSON parse failed: %@",
                       [jsonKitError description]];
        }

        LeoJSONSetError(errorString, message);
        return nil;
    }

    return object;
}

NSData *LeoJSONDataFromObject(id object,
                              LeoJSONWriteOptions options,
                              NSString **errorString)
{
    if (errorString != NULL) {
        *errorString = nil;
    }

    if (object == nil) {
        LeoJSONSetError(errorString, @"LeoJSON: input object is nil");
        return nil;
    }

    if (options != LeoJSONWriteCompact) {
        LeoJSONSetError(errorString, @"LeoJSON: unsupported write option");
        return nil;
    }

    if (![object respondsToSelector:@selector(JSONData)]) {
        LeoJSONSetError(errorString, @"LeoJSON: object cannot be serialized as JSON");
        return nil;
    }

    NSData *data = [object JSONData];

    if (data == nil || [data length] == 0) {
        LeoJSONSetError(errorString, @"LeoJSON: JSON serialization failed");
        return nil;
    }

    return data;
}
