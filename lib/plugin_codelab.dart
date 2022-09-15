import 'plugin_codelab_platform_interface.dart';

class PluginCodelab {
  Future<String?> getPlatformVersion() {
    return PluginCodelabPlatform.instance.getPlatformVersion();
  }

  Future<void> showToastMessage(String message) {
    return PluginCodelabPlatform.instance.showToastMessage(message);
  }
}
