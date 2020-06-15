#include "colors.h"


Colors::Colors() {

    QSettings settings("app", "otrainees");
    _theme =  static_cast<Theme>(settings.value("theme").toInt());

}

QColor Colors::statusBar(){

    QColor statusColor = primary().darker(90);
    return statusColor;
}

Colors::Theme Colors::theme(){

    return _theme;
}

void Colors::setTheme(Theme &theme){

    _theme = theme;

    emit themeChanged();
    emit backgroundChanged();
    emit primaryChanged();
    emit statusBarChanged();
    emit primaryMaleChanged();
    emit primaryFemaleChanged();
    emit primaryLightChanged();
    emit primaryDarkChanged();
    emit primaryTextChanged();
    emit SecundaryChanged();
    emit secundaryLightChanged();
    emit secundaryDarkChanged();
    emit secundaryTextChanged();
    emit headerTitleChanged();
    emit buttonChanged();
    emit buttonTextChanged();

    QSettings settings("app", "otrainees");
    settings.setValue("theme", theme);
}


QColor Colors::background(){

    return _background;
};

QColor Colors::primary(){

    switch (_theme) {

    case PAPAYA :
        return _primary_papaya;
    case MALE:
        return _primary_male;
    case FEMALE :
        return _primary_female;
    }

};

QColor Colors::primaryLight(){

    switch (_theme) {

    case PAPAYA :
        return _primaryLight_papaya;
    case MALE:
        return _primaryLight_male;

    case FEMALE :
        return _primaryLight_female;

    }

};

QColor Colors::primaryDark(){

    switch (_theme) {

    case PAPAYA :
        return _primaryDark_papaya;
    case MALE:
        return _primaryDark_male;

    case FEMALE :
        return _primaryDark_female;

    }

};

QColor Colors::primaryText(){

    switch (_theme) {

    case PAPAYA :
        return _primaryText_papaya;
    case MALE:
        return _primaryText_male;

    case FEMALE :
        return _primaryText_female;

    }

};

QColor Colors::secundary(){

    switch (_theme) {

    case PAPAYA :
        return _secundary_papaya;
    case MALE:
        return _secundary_male;

    case FEMALE :
        return _secundary_female;

    }

};

QColor Colors::secundaryLight(){

    switch (_theme) {

    case PAPAYA :
        return _secundaryLight_papaya;
    case MALE:
        return _secundaryLight_male;

    case FEMALE :
        return _secundaryLight_female;

    }

};
QColor Colors::secundaryDark(){

    switch (_theme) {

    case PAPAYA :
        return _secundaryDark_papaya;
    case MALE:
        return _secundaryDark_male;

    case FEMALE :
        return _secundaryDark_female;

    }

};

QColor Colors::secundaryText(){

    switch (_theme) {

    case PAPAYA :
        return _secundaryText_papaya;
    case MALE:
        return _secundaryText_male;

    case FEMALE :
        return _secundaryText_female;

    }

};

QColor Colors::headerTitle(){

    switch (_theme) {

    case PAPAYA :
        return _headerTitle_papaya;
    case MALE:
        return _headerTitle_male;

    case FEMALE :
        return _headerTitle_female;

    }

}

QColor Colors::button(){


    return _button;
}

QColor Colors::buttonText(){

    return _buttonText;
}

QColor Colors::primaryPapaya(){

    return _primary_papaya;
}


QColor Colors::primaryMale(){
    return _primary_male;
}


QColor Colors::primaryFemale(){
    return _primary_female;
}

