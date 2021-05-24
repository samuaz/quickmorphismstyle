#include "statusbar_p.h"

#include <QtAndroidExtras/QtAndroid>

// WindowManager.LayoutParams
#define FLAG_TRANSLUCENT_STATUS 0x04000000
#define FLAG_TRANSLUCENT_NAVIGATION 0x08000000
#define FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS 0x80000000
#define FLAG_LAYOUT_NO_LIMITS 0x00000200
#define FLAG_LAYOUT_ATTACHED_IN_DECOR 0x40000000
// View
#define SYSTEM_UI_FLAG_LIGHT_STATUS_BAR 0x00002000
#define SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR 0x00000010
#define SYSTEM_UI_FLAG_LAYOUT_STABLE 0x00000100
#define SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN 0x00000400
#define SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION 0x00000200
#define WINDOW_LIGHT_STATUS_BAR 0x010104e0

static QAndroidJniObject getAndroidWindow() {
  QAndroidJniObject window = QtAndroid::androidActivity().callObjectMethod(
      "getWindow", "()Landroid/view/Window;");

  return window;
}


static void hadlerColor(const QColor &color){
    QtAndroid::runOnAndroidThread([=]() {
        QAndroidJniObject window = getAndroidWindow();
        window.callMethod<void>("addFlags", "(I)V",
                                FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
        if (color.rgba() == QColor(Qt::transparent).rgba()) {
            //  window.callMethod<void>("addFlags", "(I)V", FLAG_TRANSLUCENT_STATUS);
            // window.callMethod<void>("addFlags", "(I)V",
            // FLAG_TRANSLUCENT_NAVIGATION);
            QAndroidJniObject view =
                window.callObjectMethod("getDecorView", "()Landroid/view/View;");
            view.callMethod<void>("setSystemUiVisibility", "(I)V",
                                  SYSTEM_UI_FLAG_LAYOUT_STABLE);
            view.callMethod<void>("setSystemUiVisibility", "(I)V",
                                  SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
            view.callMethod<void>("setSystemUiVisibility", "(I)V",
                                  SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION);
        } else {
            window.callMethod<void>("clearFlags", "(I)V", FLAG_TRANSLUCENT_STATUS);
            window.callMethod<void>("clearFlags", "(I)V",
                                    FLAG_TRANSLUCENT_NAVIGATION);
            window.callMethod<void>("clearFlags", "(I)V", FLAG_LAYOUT_NO_LIMITS);
            window.callMethod<void>("addFlags", "(I)V",
                                    FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
        }
    });
};


bool StatusBarPrivate::isAvailable_sys() {
  return QtAndroid::androidSdkVersion() >= 21;
}

void StatusBarPrivate::setStatusBarColor_sys(const QColor &color) {
  if (QtAndroid::androidSdkVersion() < 21) return;

  QColor statusColor;

  if(QtAndroid::androidSdkVersion() < 23){

      statusColor = color;

  }else {
      statusColor = color;
  }

  hadlerColor(color);
  QtAndroid::runOnAndroidThread([=]() {
    QAndroidJniObject window = getAndroidWindow();
    window.callMethod<void>("setStatusBarColor", "(I)V", statusColor.rgba());
  });
}

void StatusBarPrivate::setNavBarColor_sys(const QColor &color) {
    if (QtAndroid::androidSdkVersion() < 26) return;
    hadlerColor(color);
    QtAndroid::runOnAndroidThread([=]() {
        QAndroidJniObject window = getAndroidWindow();
        window.callMethod<void>("setNavigationBarColor", "(I)V", color.rgba());
    });
}


void StatusBarPrivate::setTheme_sys(StatusBar::Theme theme) {
  if (QtAndroid::androidSdkVersion() < 23) return;

  QtAndroid::runOnAndroidThread([=]() {
    QAndroidJniObject window = getAndroidWindow();
    QAndroidJniObject view =
        window.callObjectMethod("getDecorView", "()Landroid/view/View;");
    int visibility = view.callMethod<int>("getSystemUiVisibility", "()I");
    if (theme == StatusBar::Theme::Light)
      visibility |= SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
    else
      visibility &= ~SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
    view.callMethod<void>("setSystemUiVisibility", "(I)V", visibility);
  });

  if (QtAndroid::androidSdkVersion() < 26) return;
  QtAndroid::runOnAndroidThread([=]() {
      QAndroidJniObject window = getAndroidWindow();
      QAndroidJniObject view =
          window.callObjectMethod("getDecorView", "()Landroid/view/View;");
      int visibility = view.callMethod<int>("getSystemUiVisibility", "()I");
      if (theme == StatusBar::Theme::Light)
          visibility |= SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
      else
          visibility &= ~SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
      view.callMethod<void>("setSystemUiVisibility", "(I)V", visibility);
  });
}
