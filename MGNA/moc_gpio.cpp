/****************************************************************************
** Meta object code from reading C++ file 'gpio.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "gpio.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'gpio.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_GPIO_t {
    QByteArrayData data[13];
    char stringdata0[120];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_GPIO_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_GPIO_t qt_meta_stringdata_GPIO = {
    {
QT_MOC_LITERAL(0, 0, 4), // "GPIO"
QT_MOC_LITERAL(1, 5, 11), // "gpio_export"
QT_MOC_LITERAL(2, 17, 0), // ""
QT_MOC_LITERAL(3, 18, 4), // "gpio"
QT_MOC_LITERAL(4, 23, 13), // "gpio_unexport"
QT_MOC_LITERAL(5, 37, 12), // "gpio_set_dir"
QT_MOC_LITERAL(6, 50, 8), // "out_flag"
QT_MOC_LITERAL(7, 59, 14), // "gpio_set_value"
QT_MOC_LITERAL(8, 74, 5), // "value"
QT_MOC_LITERAL(9, 80, 14), // "gpio_get_value"
QT_MOC_LITERAL(10, 95, 13), // "gpio_set_edge"
QT_MOC_LITERAL(11, 109, 5), // "char*"
QT_MOC_LITERAL(12, 115, 4) // "edge"

    },
    "GPIO\0gpio_export\0\0gpio\0gpio_unexport\0"
    "gpio_set_dir\0out_flag\0gpio_set_value\0"
    "value\0gpio_get_value\0gpio_set_edge\0"
    "char*\0edge"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_GPIO[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   44,    2, 0x02 /* Public */,
       4,    1,   47,    2, 0x02 /* Public */,
       5,    2,   50,    2, 0x02 /* Public */,
       7,    2,   55,    2, 0x02 /* Public */,
       9,    1,   60,    2, 0x02 /* Public */,
      10,    2,   63,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Int, QMetaType::UInt,    3,
    QMetaType::Int, QMetaType::UInt,    3,
    QMetaType::Int, QMetaType::UInt, QMetaType::Int,    3,    6,
    QMetaType::Int, QMetaType::UInt, QMetaType::Int,    3,    8,
    QMetaType::Int, QMetaType::UInt,    3,
    QMetaType::Int, QMetaType::UInt, 0x80000000 | 11,    3,   12,

       0        // eod
};

void GPIO::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<GPIO *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { int _r = _t->gpio_export((*reinterpret_cast< uint(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 1: { int _r = _t->gpio_unexport((*reinterpret_cast< uint(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 2: { int _r = _t->gpio_set_dir((*reinterpret_cast< uint(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 3: { int _r = _t->gpio_set_value((*reinterpret_cast< uint(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 4: { int _r = _t->gpio_get_value((*reinterpret_cast< uint(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: { int _r = _t->gpio_set_edge((*reinterpret_cast< uint(*)>(_a[1])),(*reinterpret_cast< char*(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject GPIO::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_GPIO.data,
    qt_meta_data_GPIO,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *GPIO::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *GPIO::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_GPIO.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int GPIO::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
