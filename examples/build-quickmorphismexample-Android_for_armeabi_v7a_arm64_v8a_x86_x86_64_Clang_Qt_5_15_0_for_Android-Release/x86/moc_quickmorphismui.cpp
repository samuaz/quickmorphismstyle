/****************************************************************************
** Meta object code from reading C++ file 'quickmorphismui.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../src/ui/quickmorphismui.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'quickmorphismui.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_QuickMorphismUI_t {
    QByteArrayData data[22];
    char stringdata0[181];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QuickMorphismUI_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QuickMorphismUI_t qt_meta_stringdata_QuickMorphismUI = {
    {
QT_MOC_LITERAL(0, 0, 15), // "QuickMorphismUI"
QT_MOC_LITERAL(1, 16, 12), // "themeChanged"
QT_MOC_LITERAL(2, 29, 0), // ""
QT_MOC_LITERAL(3, 30, 6), // "Theme*"
QT_MOC_LITERAL(4, 37, 11), // "signalTheme"
QT_MOC_LITERAL(5, 49, 10), // "dpiChanged"
QT_MOC_LITERAL(6, 60, 3), // "Dpi"
QT_MOC_LITERAL(7, 64, 9), // "signalDpi"
QT_MOC_LITERAL(8, 74, 14), // "dpScaleChanged"
QT_MOC_LITERAL(9, 89, 13), // "signalDpScale"
QT_MOC_LITERAL(10, 103, 8), // "setTheme"
QT_MOC_LITERAL(11, 112, 5), // "theme"
QT_MOC_LITERAL(12, 118, 10), // "setDpScale"
QT_MOC_LITERAL(13, 129, 4), // "size"
QT_MOC_LITERAL(14, 134, 6), // "setDpi"
QT_MOC_LITERAL(15, 141, 3), // "dpi"
QT_MOC_LITERAL(16, 145, 7), // "dpScale"
QT_MOC_LITERAL(17, 153, 4), // "LDPI"
QT_MOC_LITERAL(18, 158, 4), // "MDPI"
QT_MOC_LITERAL(19, 163, 4), // "HDPI"
QT_MOC_LITERAL(20, 168, 5), // "XHDPI"
QT_MOC_LITERAL(21, 174, 6) // "XXHDPI"

    },
    "QuickMorphismUI\0themeChanged\0\0Theme*\0"
    "signalTheme\0dpiChanged\0Dpi\0signalDpi\0"
    "dpScaleChanged\0signalDpScale\0setTheme\0"
    "theme\0setDpScale\0size\0setDpi\0dpi\0"
    "dpScale\0LDPI\0MDPI\0HDPI\0XHDPI\0XXHDPI"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QuickMorphismUI[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       3,   62, // properties
       1,   74, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   44,    2, 0x06 /* Public */,
       5,    1,   47,    2, 0x06 /* Public */,
       8,    1,   50,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      10,    1,   53,    2, 0x0a /* Public */,
      12,    1,   56,    2, 0x0a /* Public */,
      14,    1,   59,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    4,
    QMetaType::Void, 0x80000000 | 6,    7,
    QMetaType::Void, QMetaType::Float,    9,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 3,   11,
    QMetaType::Void, QMetaType::Float,   13,
    QMetaType::Void, 0x80000000 | 6,   15,

 // properties: name, type, flags
      11, 0x80000000 | 3, 0x0049510b,
      15, 0x80000000 | 6, 0x0049510b,
      16, QMetaType::QReal, 0x00495103,

 // properties: notify_signal_id
       0,
       1,
       2,

 // enums: name, alias, flags, count, data
       6,    6, 0x0,    5,   79,

 // enum data: key, value
      17, uint(QuickMorphismUI::LDPI),
      18, uint(QuickMorphismUI::MDPI),
      19, uint(QuickMorphismUI::HDPI),
      20, uint(QuickMorphismUI::XHDPI),
      21, uint(QuickMorphismUI::XXHDPI),

       0        // eod
};

void QuickMorphismUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<QuickMorphismUI *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->themeChanged((*reinterpret_cast< Theme*(*)>(_a[1]))); break;
        case 1: _t->dpiChanged((*reinterpret_cast< Dpi(*)>(_a[1]))); break;
        case 2: _t->dpScaleChanged((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 3: _t->setTheme((*reinterpret_cast< Theme*(*)>(_a[1]))); break;
        case 4: _t->setDpScale((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 5: _t->setDpi((*reinterpret_cast< Dpi(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< Theme* >(); break;
            }
            break;
        case 3:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< Theme* >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (QuickMorphismUI::*)(Theme * );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QuickMorphismUI::themeChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (QuickMorphismUI::*)(Dpi );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QuickMorphismUI::dpiChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (QuickMorphismUI::*)(float );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&QuickMorphismUI::dpScaleChanged)) {
                *result = 2;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 0:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< Theme* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<QuickMorphismUI *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< Theme**>(_v) = _t->theme(); break;
        case 1: *reinterpret_cast< Dpi*>(_v) = _t->dpi(); break;
        case 2: *reinterpret_cast< qreal*>(_v) = _t->dpScale(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<QuickMorphismUI *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setTheme(*reinterpret_cast< Theme**>(_v)); break;
        case 1: _t->setDpi(*reinterpret_cast< Dpi*>(_v)); break;
        case 2: _t->setDpScale(*reinterpret_cast< qreal*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject QuickMorphismUI::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_QuickMorphismUI.data,
    qt_meta_data_QuickMorphismUI,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *QuickMorphismUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QuickMorphismUI::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_QuickMorphismUI.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int QuickMorphismUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void QuickMorphismUI::themeChanged(Theme * _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QuickMorphismUI::dpiChanged(Dpi _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void QuickMorphismUI::dpScaleChanged(float _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
