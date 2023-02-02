#ifndef MODBUSCONTROLLER_H
#define MODBUSCONTROLLER_H

#include <QObject>
#include <QModbusServer>
#include <QString>
#include <QModbusTcpServer>
#include <QStringList>
#include <QQmlEngine>
#include <QJSEngine>
#include <QList>

#include <QModbusDataUnit>
#include <QModbusRtuSerialMaster>
#include <QStandardItemModel>
#include <QUrl>
#include <QSerialPort>
#include <QTimer>

class ModbusController : public QObject
{
    Q_OBJECT

    QModbusServer *modbusDevice = nullptr;
    const quint16 registerCount = 10;
    bool clientIsConnected = false;
    QString ipAddress = "";

    QList<bool> coil;
    QList<bool> discreteInput;
    QList<quint16> inputRegister;
    QList<quint16> holdingRegister;
    bool tempCoil =false;

    QTimer *timer = nullptr;
    static ModbusController *m_pThis;

public:
    explicit ModbusController(QObject *parent = nullptr);
    /// Static getter
    static ModbusController *instance();
    static QObject *qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine);

    Q_PROPERTY(QString connectionMessage READ connectionMessage WRITE setConnectionMessage NOTIFY connectionMessageChanged)
    Q_PROPERTY(bool isConnected READ isConnected WRITE setIsConnected NOTIFY isConnectedChanged)

    Q_INVOKABLE void setCoilWithId(int id, bool val);
    Q_INVOKABLE bool getCoilWithId(int id);
    Q_INVOKABLE void setDiscreteInputWithId(int id, bool val);
    Q_INVOKABLE void setInputRegisterWithId(int id,quint16 value);
    Q_INVOKABLE void setHoldingRegisterWithId(int id,quint16 value);


    const QString &connectionMessage() const;
    void setConnectionMessage(const QString &newConnectionMessage);

    bool isConnected() const;
    void setIsConnected(bool newIsConnected);

private Q_SLOTS:

    void onConnectButtonClicked();
    void onStateChanged(int state);

    void coilChanged(int id, bool val);
    void discreteInputChanged(int id, bool val);
    void bitChanged(int id, QModbusDataUnit::RegisterType table, bool value);

    void setInputRegister(int id,const QString &value);
    void setHoldingRegister(int id,const QString &value);
    void updateWidgets(QModbusDataUnit::RegisterType table, int address, int size);

    void onCurrentConnectTypeChanged(int);

    void handleDeviceError(QModbusDevice::Error newError);


signals:
    void coilUpdated(int id ,bool val);
    void discreteInputUpdated(int id,bool val);
    void inputRegisterUpdated(int id,quint16 value);
    void holdingRegisterUpdated(int id,quint16 value);

    void connectionMessageChanged();

    void isConnectedChanged();

private:
    void setupDeviceData();

    QList<bool> m_coil;
    QList<bool> m_discreteInput;
    QList<quint16> m_inputRegister;
    QList<quint16> m_holdingRegister;
    QString m_connectionMessage;
    bool m_isConnected=  false;
    qint32 modbusRetryTime = 3;
    qint32 modbusRetryRemainingtime = 3;

};

#endif // MODBUSCONTROLLER_H
