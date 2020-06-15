#include "configuration.h"
QSettings Configuration::settings = QSettings();

Configuration::Configuration() {}

qreal Configuration::ppi() { return _ppi; }

QString Configuration::density() { return _density; }

QString Configuration::setPpi(qreal ppi) {
  _ppi = ppi;
  QString result = "hdpi";

  if (_ppi < 120) {
    result = "ldpi";
  } else if (_ppi > 150) {
    result = "mdpi";
  } else if (_ppi > 230) {
    result = "hdpi";
  } else if (_ppi > 310) {
    result = "xhdpi";
  } else if (_ppi > 470) {
    result = "xxhdpi";
  }
  ppiChanged();
  return setDensity(result);
}

QString Configuration::setDensity(QString density) {
  _density = density;
   densityChanged();
  return _density;
}

int Configuration::blur() { return _blur; }

QColor Configuration::background() { return _background; }

QString Configuration::imageName() { return _imageName; }

QColor Configuration::blurBackground() { return _blurBackground; }

void Configuration::setBlur(int newBlur) {
  _blur = newBlur;
  blurChanged();
}

void Configuration::setBackground(QColor bg) {
  _background = bg;
  backgroundChanged();
}
void Configuration::setBlurBackground(QColor bgblur) {
  _blurBackground = bgblur;

  blurBackgroundChanged();
}
void Configuration::setImageName(QString image) {
  _imageName = image;
  imageNameChanged();
}


StatusBar::Theme Configuration::theme()
{
    return _theme;
}

void  Configuration::setTheme(StatusBar::Theme theme)
{
    _theme = theme;
    themeChanged();
}

QColor Configuration::statusBarBackground(){
    return _statusBarBackground;
}
QColor Configuration::headerBackground(){
    return  _headerBackground;
}
QColor Configuration::footerBackground(){
    return _footerBackground;
}
QColor Configuration::navBarBackground(){

    return _navBarBackground;
}

void Configuration::setStatusBarBackground(QColor color){
    _statusBarBackground = color;
    emit statusBarBackgroundChanged();
}
void Configuration::setHeaderBackground(QColor color){
    _headerBackground = color;
    emit headerBackgroundChanged();

}
void Configuration::setFooterBackground(QColor color){
    _footerBackground = color;
    emit footerBackgroundChanged();
}
void Configuration::setNavBarBackground(QColor color){
    _navBarBackground = color;
    emit navBarBackgroundChanged();
}

bool Configuration::dimContainer(){

    return _dimMainContainer;
}

void Configuration::setDimContainer(bool dim){
    _dimMainContainer = dim;
    emit dimContainerChanged();
}

void Configuration::saveConfig(const QString& key, const QString& value){
    settings.setValue(key, value);
}

void Configuration::saveConfig(const QString &key, const bool &value)
{
    settings.setValue(key, value);
}

QString Configuration::getConfig(const QString& key){
    return settings.value(key).toString();
}

bool Configuration::getConfigBool(const QString &key)
{
    return settings.value(key).toBool();
}

void Configuration::removeConfig(const QString& key){
    settings.remove(key);
}

