/****************************************************************************
** Resource object code
**
** Created by: The Resource Compiler for Qt version 5.15.0
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

static const unsigned char qt_resource_data[] = {
  // /Users/samuaz/personal/toc/quickmorphismstyle/examples/quickmorphismexample/qtquickcontrols2.conf
  0x0,0x0,0x0,0x1a,
  0x5b,
  0x43,0x6f,0x6e,0x74,0x72,0x6f,0x6c,0x73,0x5d,0xa,0x53,0x74,0x79,0x6c,0x65,0x3d,
  0x4d,0x61,0x74,0x65,0x72,0x69,0x61,0x6c,0xa,
  
};

static const unsigned char qt_resource_name[] = {
  // qtquickcontrols2.conf
  0x0,0x15,
  0x8,0x1e,0x16,0x66,
  0x0,0x71,
  0x0,0x74,0x0,0x71,0x0,0x75,0x0,0x69,0x0,0x63,0x0,0x6b,0x0,0x63,0x0,0x6f,0x0,0x6e,0x0,0x74,0x0,0x72,0x0,0x6f,0x0,0x6c,0x0,0x73,0x0,0x32,0x0,0x2e,
  0x0,0x63,0x0,0x6f,0x0,0x6e,0x0,0x66,
  
};

static const unsigned char qt_resource_struct[] = {
  // :
  0x0,0x0,0x0,0x0,0x0,0x2,0x0,0x0,0x0,0x1,0x0,0x0,0x0,0x1,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
  // :/qtquickcontrols2.conf
  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1,0x0,0x0,0x0,0x0,
0x0,0x0,0x1,0x72,0xce,0xe8,0x1c,0x7a,

};

#ifdef QT_NAMESPACE
#  define QT_RCC_PREPEND_NAMESPACE(name) ::QT_NAMESPACE::name
#  define QT_RCC_MANGLE_NAMESPACE0(x) x
#  define QT_RCC_MANGLE_NAMESPACE1(a, b) a##_##b
#  define QT_RCC_MANGLE_NAMESPACE2(a, b) QT_RCC_MANGLE_NAMESPACE1(a,b)
#  define QT_RCC_MANGLE_NAMESPACE(name) QT_RCC_MANGLE_NAMESPACE2( \
        QT_RCC_MANGLE_NAMESPACE0(name), QT_RCC_MANGLE_NAMESPACE0(QT_NAMESPACE))
#else
#   define QT_RCC_PREPEND_NAMESPACE(name) name
#   define QT_RCC_MANGLE_NAMESPACE(name) name
#endif

#ifdef QT_NAMESPACE
namespace QT_NAMESPACE {
#endif

bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
bool qUnregisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);

#ifdef QT_NAMESPACE
}
#endif

int QT_RCC_MANGLE_NAMESPACE(qInitResources_qmake_qmake_immediate)();
int QT_RCC_MANGLE_NAMESPACE(qInitResources_qmake_qmake_immediate)()
{
    int version = 3;
    QT_RCC_PREPEND_NAMESPACE(qRegisterResourceData)
        (version, qt_resource_struct, qt_resource_name, qt_resource_data);
    return 1;
}

int QT_RCC_MANGLE_NAMESPACE(qCleanupResources_qmake_qmake_immediate)();
int QT_RCC_MANGLE_NAMESPACE(qCleanupResources_qmake_qmake_immediate)()
{
    int version = 3;
    QT_RCC_PREPEND_NAMESPACE(qUnregisterResourceData)
       (version, qt_resource_struct, qt_resource_name, qt_resource_data);
    return 1;
}

namespace {
   struct initializer {
       initializer() { QT_RCC_MANGLE_NAMESPACE(qInitResources_qmake_qmake_immediate)(); }
       ~initializer() { QT_RCC_MANGLE_NAMESPACE(qCleanupResources_qmake_qmake_immediate)(); }
   } dummy;
}
