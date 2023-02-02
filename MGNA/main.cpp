#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
//#include <QTranslator>

#include <QtQml>
#include <modbusController.h>
#include <gpio.h>

#include "ioreader.h"
#include "rnelapsedtimer.h"

int main(int argc, char *argv[])
{

    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));


#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);


    app.setOrganizationName("FUMP-ICT");
    app.setOrganizationDomain("Nourbakhsh.com");
    app.setApplicationName("FUMP-ICT Medical Gas Notification Alarm");

//    QTranslator translator;
//    const QStringList uiLanguages = QLocale::system().uiLanguages();
//    for (const QString &locale : uiLanguages) {
//        const QString baseName = "MGNA_" + QLocale(locale).name();
//        if (translator.load(":/i18n/" + baseName)) {
//            app.installTranslator(&translator);
//            break;
//        }
//    }

    qmlRegisterSingletonType(QUrl("qrc:/Colors.qml"), "App", 1, 0, "Colors");

    qmlRegisterType<IOReader>("com.nourbakhsh.IOReader",1,0,"IOReader");
    qmlRegisterType<RNElapsedTimer>("com.nourbakhsh.RNElapsedTimer",1,0,"RNElapsedTimer");
    qmlRegisterType<ModbusController>("com.nourbakhsh.ModbusController",1,0,"ModbusController");
    //qmlRegisterSingletonType<ModbusController>("com.nourbakhsh.ModbusController",1,0,"ModbusController" , &ModbusController::qmlInstance);
    qmlRegisterType<GPIO>("com.nourbakhsh.GPIO",1,0,"GPIO");

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
