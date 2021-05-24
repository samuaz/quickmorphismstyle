#include <QuickMorphismStyle/ui/snackbar.h>

Snackbar::Snackbar(){}

bool Snackbar::show(){

    return _show;
}
QString Snackbar::message(){
    return _message;

}
void Snackbar::setShow(bool show){

    _show = show;
    showChanged();
}
void Snackbar::setMessage(QString message){
    _message = message;
    messageChanged();
}
