package com.krazylabs;

import android.app.Activity;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableNativeMap;
import com.iterable.iterableapi.IterableApi;
import com.iterable.iterableapi.IterableConstants;

import java.util.HashMap;
import java.util.Map;


public class RNIterableModule extends ReactContextBaseJavaModule {
  public static final String REACT_CLASS = "RNIterable";

  private static final String ERROR_NO_ACTIVITY = "E_NO_ACTIVITY";
  private static final String ERROR_NO_ACTIVITY_MESSAGE = "Tried to do the something while not attached to an Activity";
  private static final String ERROR_NO_SHARED_INSTANCE = "ERROR_NO_SHARED_INSTANCE";

  private IterableApi m_sharedIterableApiInstance = null;

  public RNIterableModule(ReactApplicationContext context) {
    super(context);
  }

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  @Override
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    constants.put("MESSAGING_PLATFORM_GOOGLE", IterableConstants.MESSAGING_PLATFORM_GOOGLE);
    constants.put("MESSAGING_PLATFORM_FIREBASE", IterableConstants.MESSAGING_PLATFORM_FIREBASE);
    constants.put("MESSAGING_PLATFORM_AMAZON", IterableConstants.MESSAGING_PLATFORM_AMAZON);
    return constants;
  }

  @ReactMethod
  public void sharedInstanceWithApiKey(String apiKey, String email, Promise promise) {
    Activity currentActivity = getCurrentActivity();
    if (currentActivity == null) {
      promise.reject(ERROR_NO_ACTIVITY, ERROR_NO_ACTIVITY_MESSAGE);
    } else {
      m_sharedIterableApiInstance = IterableApi.sharedInstanceWithApiKey(currentActivity, apiKey, email);
      promise.resolve(createSuccessMessage("Success"));
    }
  }

  @ReactMethod
  public void registerToken(String token, String applicationName, String pushPlatform, Promise promise) {
    if (m_sharedIterableApiInstance == null) {
      promise.reject(ERROR_NO_SHARED_INSTANCE, "Attempted to call 'registerToken' before 'sharedInstanceWithApiKey'.");
      return;
    }
    m_sharedIterableApiInstance.registerDeviceToken(applicationName, token, pushPlatform);
    promise.resolve(createSuccessMessage("Success"));
  }

  @ReactMethod
  public void disableDeviceForAllUsers (String applicationName, String projectNumber, String pushServicePlatform, Promise promise) {
    if (m_sharedIterableApiInstance == null) {
      promise.reject(ERROR_NO_SHARED_INSTANCE, "Attempted to call 'disableDeviceForAllUsers' before 'sharedInstanceWithApiKey'.");
    } else{
      //m_sharedIterableApiInstance.disablePush(applicationName, projectNumber, pushServicePlatform);
      m_sharedIterableApiInstance.disablePush(applicationName, projectNumber);
      promise.resolve(createSuccessMessage("Success"));
    }
  }

  private WritableNativeMap createSuccessMessage(String message) {
    WritableNativeMap map = new WritableNativeMap();
    map.putString("msg", message);
    return map;
  }
}
