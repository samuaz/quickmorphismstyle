#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QColor>
#include <QObject>
#include <QSettings>
#include <cstdlib>
#include <iostream>
#include <statusbar.h>

class Configuration : public QObject {
  Q_OBJECT

  Q_PROPERTY(qreal ppi READ ppi WRITE setPpi NOTIFY ppiChanged)
  Q_PROPERTY(
      QString density READ density WRITE setDensity NOTIFY densityChanged)
  Q_PROPERTY(QString imageName READ imageName WRITE setImageName NOTIFY
                 imageNameChanged)
  Q_PROPERTY(QColor blurBackground READ blurBackground WRITE setBlurBackground
                 NOTIFY blurBackgroundChanged)
  Q_PROPERTY(int blur READ blur WRITE setBlur NOTIFY blurChanged)
  Q_PROPERTY(StatusBar::Theme theme READ theme WRITE setTheme NOTIFY themeChanged)
  Q_PROPERTY(QColor background READ background WRITE setBackground NOTIFY
                 backgroundChanged)
  Q_PROPERTY(QColor statusBarBackground READ statusBarBackground WRITE setStatusBarBackground NOTIFY
                 statusBarBackgroundChanged)
  Q_PROPERTY(QColor navBarBackground READ navBarBackground WRITE setNavBarBackground NOTIFY
                 navBarBackgroundChanged)
  Q_PROPERTY(QColor headerBackground READ headerBackground WRITE setHeaderBackground NOTIFY
                 headerBackgroundChanged)
  Q_PROPERTY(QColor footerBackground READ footerBackground WRITE setFooterBackground NOTIFY
                 footerBackgroundChanged)
  Q_PROPERTY(bool dimContainer READ dimContainer WRITE setDimContainer NOTIFY dimContainerChanged)



 public:
  Configuration();
  qreal ppi();
  QString density();
  Q_INVOKABLE QString setPpi(qreal);
  Q_INVOKABLE QString setDensity(QString);
  QColor background();
  QColor statusBarBackground();
  QColor headerBackground();
  QColor footerBackground();
  QColor navBarBackground();
  QString imageName();
  QColor blurBackground();
  StatusBar::Theme theme();
  int blur();
  bool dimContainer();
  Q_INVOKABLE void setBlur(int);
  Q_INVOKABLE void setBlurBackground(QColor);
  Q_INVOKABLE void setImageName(QString);
  Q_INVOKABLE void setTheme(StatusBar::Theme);
  Q_INVOKABLE void setBackground(QColor);
  Q_INVOKABLE void setStatusBarBackground(QColor);
  Q_INVOKABLE void setHeaderBackground(QColor);
  Q_INVOKABLE void setFooterBackground(QColor);
  Q_INVOKABLE void setNavBarBackground(QColor);
  Q_INVOKABLE void setDimContainer(bool);
  Q_INVOKABLE static void saveConfig(const QString& key, const QString& value);
  Q_INVOKABLE static void saveConfig(const QString &key, const bool &value);
  Q_INVOKABLE static QString getConfig(const QString& key);
  Q_INVOKABLE static bool getConfigBool(const QString &key);
  Q_INVOKABLE static void removeConfig(const QString& key);

 signals:
  void ppiChanged();
  void densityChanged();
  void blurChanged();
  void imageNameChanged();
  void blurBackgroundChanged();
  void themeChanged();
  void backgroundChanged();
  void statusBarBackgroundChanged();
  void navBarBackgroundChanged();
  void headerBackgroundChanged();
  void footerBackgroundChanged();
  void dimContainerChanged();

 private:
  qreal _ppi = 0;
  QString _density;
  QColor _background = QColor("#FAFAFA");
  QColor _statusBarBackground;
  QColor _headerBackground;
  QColor _footerBackground;
  QColor _navBarBackground;
  QColor _blurBackground = QColor(Qt::transparent);
  QString _imageName;
  int _blur = 0;
  StatusBar::Theme _theme;
  bool _dimMainContainer;
  static QSettings settings;
};

#endif  // CONFIGURATION_H
