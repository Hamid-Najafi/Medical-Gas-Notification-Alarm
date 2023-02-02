#include "gpio.h"
#include "QFile"
#include <QDebug>
GPIO::GPIO(QObject *parent)
    : QObject{parent}
{

}

/****************************************************************
 * gpio_export
 ****************************************************************/
int GPIO::gpio_export(unsigned int gpio)
{

    QFile exportFile( SYSFS_GPIO_DIR "/export" );

    if ( exportFile.open( QIODevice::WriteOnly ) )
    {
      QTextStream exportStream( &exportFile );

      exportStream << gpio;

      exportFile.close();

      return gpio;
     }

    return -1;
}
/****************************************************************
 * gpio_unexport
 ****************************************************************/
int GPIO::gpio_unexport(unsigned int gpio)
{

    QFile exportFile( SYSFS_GPIO_DIR "/unexport" );

    if ( exportFile.open( QIODevice::WriteOnly ) )
    {
      QTextStream exportStream( &exportFile );

      exportStream << gpio;

      exportFile.close();

      return gpio;
     }

    return -1;
}
/****************************************************************
 * gpio_set_dir
 ****************************************************************/
int GPIO::gpio_set_dir(unsigned int gpio, int out_flag)
{
    QString str = QString(SYSFS_GPIO_DIR "/gpio%1/direction").arg(gpio);
    QFile exportFile( str );

    if ( exportFile.open( QIODevice::WriteOnly ) )
    {
      QTextStream exportStream( &exportFile );

      if (out_flag == OUTPUT_PIN)
          exportStream << "out";
      else
          exportStream << "int";

      exportFile.close();

      return gpio;
     }

    return -1;
}

/****************************************************************
 * gpio_set_value
 ****************************************************************/
int GPIO::gpio_set_value(unsigned int gpio, int value)
{
    QString str = QString(SYSFS_GPIO_DIR "/gpio%1/value").arg(gpio);
    QFile exportFile( str );

    if ( exportFile.open( QIODevice::WriteOnly ) )
    {
      QTextStream exportStream( &exportFile );


      if (value == LOW)
          exportStream << "0";
      else
          exportStream << "1";

      exportFile.close();

      return gpio;
     }

    return -1;

}
/****************************************************************
 * gpio_get_value
 ****************************************************************/
int GPIO::gpio_get_value(unsigned int gpio)
{

    QString str = QString(SYSFS_GPIO_DIR "/gpio%1/value").arg(gpio);
    QFile exportFile( str );

    if ( exportFile.open( QIODevice::ReadOnly ) )
    {
      QTextStream exportStream( &exportFile );

      char ch;
      unsigned int value=0;

      exportStream >> ch;

      if (ch != '0') {
          value = 1;
      } else {
          value = 0;
      }

      exportFile.close();

      return value;
     }

    return -1;

}

/****************************************************************
 * gpio_set_edge
 ****************************************************************/

int GPIO::gpio_set_edge(unsigned int gpio, char *edge)
{

    QString str = QString(SYSFS_GPIO_DIR "/gpio%1/edge").arg(gpio);
    QFile exportFile( str );

    if ( exportFile.open( QIODevice::WriteOnly ) )
    {
      QTextStream exportStream( &exportFile );

      exportStream << edge;

      exportFile.close();

      return gpio;
     }

    return -1;
}
