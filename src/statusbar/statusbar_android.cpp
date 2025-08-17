#include <QuickMorphismStyle/statusbar/statusbar_p.h>

#include <QJniObject>
#include <QCoreApplication>

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

static QJniObject getAndroidWindow() {
    QJniObject activity = QJniObject::callStaticObjectMethod("org/qtproject/qt/android/QtNative",
                                                             "activity",
                                                             "()Landroid/app/Activity;");
    return activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
}


static void handlerColor(const QColor &color){
    QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
        QJniObject window = getAndroidWindow();
        window.callMethod<void>("addFlags", "(I)V",
                                FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
        if (color.rgba() == QColor(Qt::transparent).rgba()) {
            //  window.callMethod<void>("addFlags", "(I)V", FLAG_TRANSLUCENT_STATUS);
            // window.callMethod<void>("addFlags", "(I)V",
            // FLAG_TRANSLUCENT_NAVIGATION);
            QJniObject view =
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
}


bool StatusBarPrivate::isAvailable_sys() {
  return QNativeInterface::QAndroidApplication::sdkVersion() >= 21;
}

void StatusBarPrivate::setStatusBarColor_sys(const QColor &color) {

    int sdkVersion = QNativeInterface::QAndroidApplication::sdkVersion();

  if (sdkVersion < 21) return;

  QColor statusColor;

  if(sdkVersion < 23){

      statusColor = color;

  }else {
      statusColor = color;
  }

  handlerColor(color);
  QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
    QJniObject window = getAndroidWindow();
    window.callMethod<void>("setStatusBarColor", "(I)V", statusColor.rgba());
  });
}

void StatusBarPrivate::setNavBarColor_sys(const QColor &color) {
    if (QNativeInterface::QAndroidApplication::sdkVersion() < 26) return;
    handlerColor(color);
    QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
        QJniObject window = getAndroidWindow();
        window.callMethod<void>("setNavigationBarColor", "(I)V", color.rgba());
    });
}


void StatusBarPrivate::setTheme_sys(StatusBar::Theme theme) {
    int sdkVersion = QNativeInterface::QAndroidApplication::sdkVersion();

  if (sdkVersion < 23) return;

  QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
    QJniObject window = getAndroidWindow();
    QJniObject view =
        window.callObjectMethod("getDecorView", "()Landroid/view/View;");
    int visibility = view.callMethod<int>("getSystemUiVisibility", "()I");
    if (theme == StatusBar::Theme::Light)
      visibility |= SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
    else
      visibility &= ~SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
    view.callMethod<void>("setSystemUiVisibility", "(I)V", visibility);
  });

  if (sdkVersion < 26) return;
  QNativeInterface::QAndroidApplication::runOnAndroidMainThread([=]() {
      QJniObject window = getAndroidWindow();
      QJniObject view =
          window.callObjectMethod("getDecorView", "()Landroid/view/View;");
      int visibility = view.callMethod<int>("getSystemUiVisibility", "()I");
      if (theme == StatusBar::Theme::Light)
          visibility |= SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
      else
          visibility &= ~SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
      view.callMethod<void>("setSystemUiVisibility", "(I)V", visibility);
  });
}
