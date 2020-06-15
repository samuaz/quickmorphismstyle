#ifndef BACKGROUND_H
#define BACKGROUND_H

#include <QObject>
#include <QColor>
#include <QSettings>


class Colors : public QObject {
  Q_OBJECT
  Q_PROPERTY(Theme theme READ theme WRITE setTheme NOTIFY themeChanged)
  Q_PROPERTY(QColor background READ background NOTIFY backgroundChanged)
  Q_PROPERTY(QColor primary READ primary NOTIFY primaryChanged)
  Q_PROPERTY(QColor primaryLight READ primaryLight NOTIFY primaryLightChanged)
  Q_PROPERTY(QColor primaryDark READ primaryDark NOTIFY primaryDarkChanged)
  Q_PROPERTY(QColor primaryText READ primaryText NOTIFY primaryTextChanged)
  Q_PROPERTY(QColor secundary READ secundary NOTIFY SecundaryChanged)
  Q_PROPERTY(QColor secundaryLight READ secundaryLight NOTIFY secundaryLightChanged)
  Q_PROPERTY(QColor secundaryDark READ secundaryDark NOTIFY secundaryDarkChanged)
  Q_PROPERTY(QColor secundaryText READ secundaryText NOTIFY secundaryTextChanged)
  Q_PROPERTY(QColor buttonText READ buttonText NOTIFY buttonTextChanged)
  Q_PROPERTY(QColor button READ button NOTIFY buttonChanged)
  Q_PROPERTY(QColor headerTitle READ headerTitle NOTIFY headerTitleChanged)
  Q_PROPERTY(QColor primaryPapaya READ primaryPapaya NOTIFY primaryPapayaChanged)
  Q_PROPERTY(QColor primaryMale READ primaryMale NOTIFY primaryMaleChanged)
  Q_PROPERTY(QColor primaryFemale READ primaryFemale NOTIFY primaryFemaleChanged)
  Q_PROPERTY(QColor statusBar READ statusBar NOTIFY statusBarChanged)

 public:
  Colors();
  QColor statusBar();
  QColor background();
  QColor primary();
  QColor primaryLight();
  QColor primaryDark();
  QColor primaryText();
  QColor secundary();
  QColor secundaryLight();
  QColor secundaryDark();
  QColor secundaryText();
  QColor headerTitle();
  QColor button();
  QColor buttonText();
  QColor primaryPapaya();
  QColor primaryMale();
  QColor primaryFemale();
  enum Theme {MALE, FEMALE, PAPAYA};
  Q_ENUM(Theme)
  Theme theme();
  void setTheme(Theme &theme);

  signals:
      void themeChanged();
      void backgroundChanged();
      void statusBarChanged();
      void primaryChanged();
      void primaryPapayaChanged();
      void primaryMaleChanged();
      void primaryFemaleChanged();
      void primaryLightChanged();
      void primaryDarkChanged();
      void primaryTextChanged();
      void SecundaryChanged();
      void secundaryLightChanged();
      void secundaryDarkChanged();
      void secundaryTextChanged();
      void headerTitleChanged();
      void buttonChanged();
      void buttonTextChanged();


 private:
  Theme _theme = Theme::PAPAYA;
  QColor _background = QColor("#FAFAFA");
  QColor _button = QColor("#7CB342");
  QColor _buttonText = QColor("#FFFFFF");


  //Papaya default colors
  QColor _primary_papaya = QColor("#FFD54F");
  QColor _primaryLight_papaya = QColor("#ffff81");
  QColor _primaryDark_papaya = QColor("#c8a415");
  QColor _primaryText_papaya = QColor("#424242");
  QColor _secundary_papaya = QColor("#FFAB40");
  QColor _secundaryLight_papaya = QColor("#ffa1c1");
  QColor _secundaryDark_papaya = QColor("#29434e");
  QColor _secundaryText_papaya = QColor("#646464");
  QColor _headerTitle_papaya = QColor("#7CB342");
  QColor _button_papaya = QColor("#7CB342");
  QColor _buttonText_papaya = QColor("#FFFFFF");


  //female colors
  QColor _primary_female = QColor("#FF6F91"); //FF9671
  QColor _primaryLight_female = QColor("#b68cf5");
  QColor _primaryDark_female = QColor("#533391");
  QColor _primaryText_female = QColor("#424242");
  QColor _secundary_female = QColor("#FFAB40");
  QColor _secundaryLight_female = QColor("#ff9671");
  QColor _secundaryDark_female = QColor("#d65db1");
  QColor _secundaryText_female = QColor("#646464");
  QColor _headerTitle_female = QColor("#ffffff");
  QColor _button_female = QColor("#7CB342");
  QColor _buttonText_female = QColor("#FFFFFF");

  //male colors
  QColor _primary_male = QColor("#A7D7C5");
  QColor _primaryLight_male = QColor("#e1eff7");
  QColor _primaryDark_male = QColor("#808d94");
  QColor _primaryText_male = QColor("#424242");
  QColor _secundary_male = QColor("#FFAB40");
  QColor _secundaryLight_male = QColor("#819ca9");
  QColor _secundaryDark_male = QColor("#29434e");
  QColor _secundaryText_male = QColor("#646464");
  QColor _headerTitle_male = QColor("#ffffff");
  QColor _button_male = QColor("#7CB342");
  QColor _buttonText_male = QColor("#FFFFFF");


};

#endif  // BACKGROUND_H
