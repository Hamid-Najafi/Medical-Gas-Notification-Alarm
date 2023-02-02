#include "modbusController.h"
#include <QDebug>
#include <QUrl>
#include <QHostAddress>
#include <QNetworkInterface>
#include <QStandardPaths>
#include <QProcess>
#include <QStringList>
#include <QDir>

ModbusController* ModbusController::m_pThis = nullptr;
ModbusController::ModbusController(QObject *parent)
    : QObject{parent}
{
    setIsConnected(false);

    onCurrentConnectTypeChanged(1);
    onConnectButtonClicked();

}

ModbusController *ModbusController::instance()
{
    if (m_pThis == nullptr) // avoid creation of new instances
        m_pThis = new ModbusController();
    return m_pThis;
}

QObject *ModbusController::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    // C++ and QML instance they are the same instance
    return ModbusController::instance();
}

void ModbusController::setCoilWithId(int id, bool val)
{
    coil[id] = val;

    bitChanged(id, QModbusDataUnit::Coils, coil[id]);
}

bool ModbusController::getCoilWithId(int id)
{
    if(!modbusDevice) return 0;
    quint16 value;
    modbusDevice->data(QModbusDataUnit::Coils, id, &value);
    return value;
}

void ModbusController::setDiscreteInputWithId(int id, bool val)
{
    discreteInput[id] = val;
    bitChanged(id, QModbusDataUnit::DiscreteInputs, discreteInput[id]);
}

void ModbusController::setInputRegisterWithId(int id, quint16 value)
{
    if (!modbusDevice)
        return;

    bool ok = true;
    ok = modbusDevice->setData(QModbusDataUnit::InputRegisters, id, value);
    if (!ok)
    {
        //logger->error("Modbus: " + tr("Could not set register: ") + modbusDevice->errorString());
    }
}

void ModbusController::setHoldingRegisterWithId(int id, quint16 value)
{
    if (!modbusDevice)
        return;

    bool ok = true;
    ok = modbusDevice->setData(QModbusDataUnit::HoldingRegisters, id, value);
    if (!ok)
    {
//        //logger->error("Modbus: " + tr("Could not set register: ") + modbusDevice->errorString());
    }
}

void ModbusController::onConnectButtonClicked()
{
    bool intendToConnect = true;

    const QHostAddress &localhost = QHostAddress(QHostAddress::LocalHost);
    for (const QHostAddress &address: QNetworkInterface::allAddresses()) {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != localhost)
        {
            this->ipAddress = address.toString();
            qDebug() << address.toString();
        }
    }

    if (intendToConnect) {
        QString ipPort = this->ipAddress + ":65500";
        const QUrl url = QUrl::fromUserInput(ipPort);
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkPortParameter, url.port());
        modbusDevice->setConnectionParameter(QModbusDevice::NetworkAddressParameter, url.host());
        modbusDevice->setConnectionParameter(QModbusDevice::TimeoutError,3000);

        modbusDevice->setServerAddress(1);
        if (!modbusDevice->connectDevice()) {
            qDebug() << tr("Connect failed: ") + modbusDevice->errorString();
            setIsConnected(false);
            //logger->error(tr("Connect failed: ") + modbusDevice->errorString());
        } else {
            qDebug() << "Modbus Server connected.";
            setIsConnected(true);
            //logger->info("Modbus Server connected.");
        }
    }
}

void ModbusController::onStateChanged(int state)
{
    clientIsConnected = (state != QModbusDevice::UnconnectedState);
    if (state == QModbusDevice::UnconnectedState)
    {
        qDebug() << "Modbus Server disconnecteds.";
        setIsConnected(false);
        //logger->info("Modbus Server disconnecteds.");
    }
    else if (state == QModbusDevice::ConnectedState)
    {
        qDebug() << "Modbus Server connected.";
        setIsConnected(true);
        //logger->info("Modbus Server connected.");
    }
}

void ModbusController::coilChanged(int id, bool val)
{
    coil[id] = val;
    bitChanged(id, QModbusDataUnit::Coils, coil[id]);
    coilUpdated(id ,val);
}

void ModbusController::discreteInputChanged(int id, bool val)
{
    discreteInput[id] = val;
    bitChanged(id, QModbusDataUnit::DiscreteInputs, discreteInput[id]);
    discreteInputUpdated(id,val);
}

void ModbusController::bitChanged(int id, QModbusDataUnit::RegisterType table, bool value)
{

    if (!modbusDevice )
        return;

    if (!modbusDevice->setData(table, quint16(id), value))
    {
//        //logger->error("Modbus: " + tr("Could not set data: ") + modbusDevice->errorString());
}}

void ModbusController::setInputRegister(int id, const QString &value)
{
    if (!modbusDevice)
        return;

    bool ok = true;
    ok = modbusDevice->setData(QModbusDataUnit::InputRegisters, id, value.toUShort(&ok, 16));
    if (!ok)
    {
//        //logger->error("Modbus: " + tr("Could not set register: ") + modbusDevice->errorString());
    }else{
        inputRegisterUpdated(id,value.toUShort(&ok, 16));
    }

}

void ModbusController::setHoldingRegister(int id, const QString &value)
{
    if (!modbusDevice)
        return;

    bool ok = true;
    ok = modbusDevice->setData(QModbusDataUnit::HoldingRegisters, id, value.toUShort(&ok, 16));
    if (!ok)
    {
        //logger->error("Modbus: " + tr("Could not set register: ") + modbusDevice->errorString());
    }else{
        holdingRegisterUpdated(id,value.toUShort(&ok, 16));
    }
}

void ModbusController::updateWidgets(QModbusDataUnit::RegisterType table, int address, int size)
{
    for (int i = 0; i < size; ++i) {
        quint16 value;
        QString text;
        switch (table) {
        case QModbusDataUnit::Coils:
            modbusDevice->data(QModbusDataUnit::Coils, quint16(address + i), &value);
            coil[address + i ] = (value != 0);
            coilUpdated(address + i,coil[address + i ] );
            break;
        case QModbusDataUnit::HoldingRegisters:
            modbusDevice->data(QModbusDataUnit::HoldingRegisters, quint16(address + i), &value);
            holdingRegister[address + i] = value;
            holdingRegisterUpdated(address + i,value);
            break;
        default:
            break;
        }
    }
}

void ModbusController::onCurrentConnectTypeChanged(int)
{
    if (modbusDevice) {
        modbusDevice->disconnect();
        delete modbusDevice;
        modbusDevice = nullptr;
    }


    modbusDevice = new QModbusTcpServer(this);

    if (!modbusDevice) {
        qDebug() << (tr("Could not create Modbus server."));

        setIsConnected(false);
        //logger->error("Could not create Modbus server.");
    } else {
        QModbusDataUnitMap reg;
        reg.insert(QModbusDataUnit::Coils, { QModbusDataUnit::Coils, 0, registerCount });
        reg.insert(QModbusDataUnit::DiscreteInputs, { QModbusDataUnit::DiscreteInputs, 0, registerCount });
        reg.insert(QModbusDataUnit::InputRegisters, { QModbusDataUnit::InputRegisters, 0, registerCount });
        reg.insert(QModbusDataUnit::HoldingRegisters, { QModbusDataUnit::HoldingRegisters, 0, registerCount });

        modbusDevice->setMap(reg);

        connect(modbusDevice, &QModbusServer::dataWritten,
                this, &ModbusController::updateWidgets);
        connect(modbusDevice, &QModbusServer::stateChanged,
                this, &ModbusController::onStateChanged);
        connect(modbusDevice, &QModbusServer::errorOccurred,
                this, &ModbusController::handleDeviceError);

        setupDeviceData();
    }
}

void ModbusController::handleDeviceError(QModbusDevice::Error newError)
{
    qDebug() << "Modbus : "+modbusDevice->errorString();
    if (newError == QModbusDevice::NoError || !modbusDevice)
        return;
    //logger->error("Modbus : "+modbusDevice->errorString());

}

void ModbusController::setupDeviceData()
{
    if (!modbusDevice)
        return;

    for (quint16 i = 0; i < registerCount; ++i) {
        coil.append(false);
        discreteInput.append(false);
        inputRegister.append(0);
        holdingRegister.append(0);
        modbusDevice->setData(QModbusDataUnit::Coils, i, false);
        modbusDevice->setData(QModbusDataUnit::DiscreteInputs, i,false);
        modbusDevice->setData(QModbusDataUnit::InputRegisters, i,0);
        modbusDevice->setData(QModbusDataUnit::HoldingRegisters, i, 0);
    }
}

const QString &ModbusController::connectionMessage() const
{
    return m_connectionMessage;
}

void ModbusController::setConnectionMessage(const QString &newConnectionMessage)
{
    if (m_connectionMessage == newConnectionMessage)
        return;
    m_connectionMessage = newConnectionMessage;
    emit connectionMessageChanged();
}

bool ModbusController::isConnected() const
{
    return m_isConnected;
}

void ModbusController::setIsConnected(bool newIsConnected)
{
    if (m_isConnected == newIsConnected)
        return;
    m_isConnected = newIsConnected;
    emit isConnectedChanged();
}
