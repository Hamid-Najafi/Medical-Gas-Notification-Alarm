#ifndef GPIO_H
#define GPIO_H

#include <QObject>
#include <QString>
#include <iostream>
#include <fstream>
#include <QFile>
#include <QTextStream>
#include <QDebug>
using namespace std;

#define SYSFS_GPIO_DIR "/sys/class/gpio"

enum PIN_DIRECTION{
   INPUT_PIN=0,
   OUTPUT_PIN=1
};

enum PIN_VALUE{
   LOW=0,
   HIGH=1
};

class GPIO : public QObject
{
    Q_OBJECT
public:
    explicit GPIO(QObject *parent = nullptr);
    /****************************************************************
     * gpio_export
     ****************************************************************/
    Q_INVOKABLE int gpio_export(unsigned int gpio);
    Q_INVOKABLE int gpio_unexport(unsigned int gpio);
    Q_INVOKABLE int gpio_set_dir(unsigned int gpio, int out_flag);
    Q_INVOKABLE int gpio_set_value(unsigned int gpio, int value);
    Q_INVOKABLE int gpio_get_value(unsigned int gpio);
    Q_INVOKABLE int gpio_set_edge(unsigned int gpio, char *edge);

};

#endif // GPIO_H
