#import "LeoJSON.h"
#import "LeoJSONKitEngine.h"

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

    if ([data length] == 0) {
        LeoJSONSetError(errorString, @"LeoJSON: input data is empty");
        return nil;
    }

    if (options != LeoJSONReadStrict) {
        LeoJSONSetError(errorString, @"LeoJSON: unsupported read option");
        return nil;
    }

    return LeoJSONKitEngineObjectFromData(data, errorString);
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

    return LeoJSONKitEngineDataFromObject(object, errorString);
}
