/****************************************************************************
** Meta object code from reading C++ file 'modbusController.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "modbusController.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'modbusController.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ModbusController_t {
    QByteArrayData data[35];
    char stringdata0[544];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ModbusController_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ModbusController_t qt_meta_stringdata_ModbusController = {
    {
QT_MOC_LITERAL(0, 0, 16), // "ModbusController"
QT_MOC_LITERAL(1, 17, 11), // "coilUpdated"
QT_MOC_LITERAL(2, 29, 0), // ""
QT_MOC_LITERAL(3, 30, 2), // "id"
QT_MOC_LITERAL(4, 33, 3), // "val"
QT_MOC_LITERAL(5, 37, 20), // "discreteInputUpdated"
QT_MOC_LITERAL(6, 58, 20), // "inputRegisterUpdated"
QT_MOC_LITERAL(7, 79, 5), // "value"
QT_MOC_LITERAL(8, 85, 22), // "holdingRegisterUpdated"
QT_MOC_LITERAL(9, 108, 24), // "connectionMessageChanged"
QT_MOC_LITERAL(10, 133, 18), // "isConnectedChanged"
QT_MOC_LITERAL(11, 152, 22), // "onConnectButtonClicked"
QT_MOC_LITERAL(12, 175, 14), // "onStateChanged"
QT_MOC_LITERAL(13, 190, 5), // "state"
QT_MOC_LITERAL(14, 196, 11), // "coilChanged"
QT_MOC_LITERAL(15, 208, 20), // "discreteInputChanged"
QT_MOC_LITERAL(16, 229, 10), // "bitChanged"
QT_MOC_LITERAL(17, 240, 29), // "QModbusDataUnit::RegisterType"
QT_MOC_LITERAL(18, 270, 5), // "table"
QT_MOC_LITERAL(19, 276, 16), // "setInputRegister"
QT_MOC_LITERAL(20, 293, 18), // "setHoldingRegister"
QT_MOC_LITERAL(21, 312, 13), // "updateWidgets"
QT_MOC_LITERAL(22, 326, 7), // "address"
QT_MOC_LITERAL(23, 334, 4), // "size"
QT_MOC_LITERAL(24, 339, 27), // "onCurrentConnectTypeChanged"
QT_MOC_LITERAL(25, 367, 17), // "handleDeviceError"
QT_MOC_LITERAL(26, 385, 20), // "QModbusDevice::Error"
QT_MOC_LITERAL(27, 406, 8), // "newError"
QT_MOC_LITERAL(28, 415, 13), // "setCoilWithId"
QT_MOC_LITERAL(29, 429, 13), // "getCoilWithId"
QT_MOC_LITERAL(30, 443, 22), // "setDiscreteInputWithId"
QT_MOC_LITERAL(31, 466, 22), // "setInputRegisterWithId"
QT_MOC_LITERAL(32, 489, 24), // "setHoldingRegisterWithId"
QT_MOC_LITERAL(33, 514, 17), // "connectionMessage"
QT_MOC_LITERAL(34, 532, 11) // "isConnected"

    },
    "ModbusController\0coilUpdated\0\0id\0val\0"
    "discreteInputUpdated\0inputRegisterUpdated\0"
    "value\0holdingRegisterUpdated\0"
    "connectionMessageChanged\0isConnectedChanged\0"
    "onConnectButtonClicked\0onStateChanged\0"
    "state\0coilChanged\0discreteInputChanged\0"
    "bitChanged\0QModbusDataUnit::RegisterType\0"
    "table\0setInputRegister\0setHoldingRegister\0"
    "updateWidgets\0address\0size\0"
    "onCurrentConnectTypeChanged\0"
    "handleDeviceError\0QModbusDevice::Error\0"
    "newError\0setCoilWithId\0getCoilWithId\0"
    "setDiscreteInputWithId\0setInputRegisterWithId\0"
    "setHoldingRegisterWithId\0connectionMessage\0"
    "isConnected"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ModbusController[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      21,   14, // methods
       2,  208, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    2,  119,    2, 0x06 /* Public */,
       5,    2,  124,    2, 0x06 /* Public */,
       6,    2,  129,    2, 0x06 /* Public */,
       8,    2,  134,    2, 0x06 /* Public */,
       9,    0,  139,    2, 0x06 /* Public */,
      10,    0,  140,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      11,    0,  141,    2, 0x08 /* Private */,
      12,    1,  142,    2, 0x08 /* Private */,
      14,    2,  145,    2, 0x08 /* Private */,
      15,    2,  150,    2, 0x08 /* Private */,
      16,    3,  155,    2, 0x08 /* Private */,
      19,    2,  162,    2, 0x08 /* Private */,
      20,    2,  167,    2, 0x08 /* Private */,
      21,    3,  172,    2, 0x08 /* Private */,
      24,    1,  179,    2, 0x08 /* Private */,
      25,    1,  182,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
      28,    2,  185,    2, 0x02 /* Public */,
      29,    1,  190,    2, 0x02 /* Public */,
      30,    2,  193,    2, 0x02 /* Public */,
      31,    2,  198,    2, 0x02 /* Public */,
      32,    2,  203,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int, QMetaType::UShort,    3,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::UShort,    3,    7,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,   13,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int, 0x80000000 | 17, QMetaType::Bool,    3,   18,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    3,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    3,    7,
    QMetaType::Void, 0x80000000 | 17, QMetaType::Int, QMetaType::Int,   18,   22,   23,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void, 0x80000000 | 26,   27,

 // methods: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Bool, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int, QMetaType::Bool,    3,    4,
    QMetaType::Void, QMetaType::Int, QMetaType::UShort,    3,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::UShort,    3,    7,

 // properties: name, type, flags
      33, QMetaType::QString, 0x00495103,
      34, QMetaType::Bool, 0x00495103,

 // properties: notify_signal_id
       4,
       5,

       0        // eod
};

void ModbusController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ModbusController *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->coilUpdated((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 1: _t->discreteInputUpdated((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 2: _t->inputRegisterUpdated((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< quint16(*)>(_a[2]))); break;
        case 3: _t->holdingRegisterUpdated((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< quint16(*)>(_a[2]))); break;
        case 4: _t->connectionMessageChanged(); break;
        case 5: _t->isConnectedChanged(); break;
        case 6: _t->onConnectButtonClicked(); break;
        case 7: _t->onStateChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: _t->coilChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 9: _t->discreteInputChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 10: _t->bitChanged((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< QModbusDataUnit::RegisterType(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3]))); break;
        case 11: _t->setInputRegister((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 12: _t->setHoldingRegister((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 13: _t->updateWidgets((*reinterpret_cast< QModbusDataUnit::RegisterType(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 14: _t->onCurrentConnectTypeChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 15: _t->handleDeviceError((*reinterpret_cast< QModbusDevice::Error(*)>(_a[1]))); break;
        case 16: _t->setCoilWithId((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 17: { bool _r = _t->getCoilWithId((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 18: _t->setDiscreteInputWithId((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 19: _t->setInputRegisterWithId((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< quint16(*)>(_a[2]))); break;
        case 20: _t->setHoldingRegisterWithId((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< quint16(*)>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 10:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QModbusDataUnit::RegisterType >(); break;
            }
            break;
        case 13:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QModbusDataUnit::RegisterType >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ModbusController::*)(int , bool );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::coilUpdated)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ModbusController::*)(int , bool );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::discreteInputUpdated)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ModbusController::*)(int , quint16 );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::inputRegisterUpdated)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ModbusController::*)(int , quint16 );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::holdingRegisterUpdated)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (ModbusController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::connectionMessageChanged)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (ModbusController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ModbusController::isConnectedChanged)) {
                *result = 5;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ModbusController *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->connectionMessage(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isConnected(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ModbusController *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setConnectionMessage(*reinterpret_cast< QString*>(_v)); break;
        case 1: _t->setIsConnected(*reinterpret_cast< bool*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject ModbusController::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ModbusController.data,
    qt_meta_data_ModbusController,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ModbusController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ModbusController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ModbusController.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ModbusController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 21)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 21;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 21)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 21;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ModbusController::coilUpdated(int _t1, bool _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ModbusController::discreteInputUpdated(int _t1, bool _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void ModbusController::inputRegisterUpdated(int _t1, quint16 _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void ModbusController::holdingRegisterUpdated(int _t1, quint16 _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void ModbusController::connectionMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void ModbusController::isConnectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
