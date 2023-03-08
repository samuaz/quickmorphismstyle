#ifndef SNACKBAR_H
#define SNACKBAR_H

#include <QObject>
#include <QtQml>

class Snackbar: public QObject {
    Q_OBJECT
    Q_PROPERTY(bool show READ show WRITE setShow NOTIFY showChanged)
    Q_PROPERTY(
        QString message READ message WRITE setMessage NOTIFY messageChanged)
    QML_NAMED_ELEMENT("QuickMorphismSnackBar")

public:
    Snackbar();
    bool show();
    QString message();
    Q_INVOKABLE void setShow(bool show);
    Q_INVOKABLE void setMessage(QString message);

signals:
    void showChanged();
    void messageChanged();

private:
    bool _show = false;
    QString _message;
};


#endif // SNACKBAR_H
