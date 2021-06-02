# This Python file uses the following encoding: utf-8
import sys
import os
import socket
import time
import serial
import time
import codecs
import pickle

from PySide2.QtQml import QQmlApplicationEngine
#from PySide2.QtGui import QGuiApplication
#from PySide2.QtCore import QObject, Slot, Signal

from PySide2.QtGui import *
from PySide2.QtCore import *


# Seri haberleşmede okuma işlemi için oluşturulan THREAD
class readThread(QThread):

    def __init__(self,threadID, name):
      super(readThread, self).__init__()
      #Thread.__init__(self)
      self.threadID = threadID
      self.name = name
      self.counter = 0

    def run(self):
      self.counter = 0
      print("Starting Read Thread " + self.name)
      while(1):
          print("R = ",self.counter)
          self.counter = self.counter + 1
          time.sleep(0.1)

    def stop(self):
        print("Stop Read Thread... =",self.name)
        self.terminate()

# Seri haberleşmede yazma işlemi için oluşturulan THREAD
class writeThread(QThread):
    def __init__(self,threadID, name):
        super(writeThread, self).__init__()
        #Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = 0

    def run(self):
        print("Starting Write Thread " + self.name)
        self.counter = 0
        while(1):
            print("W = ",self.counter)
            self.counter = self.counter + 1
            time.sleep(0.5)

    def stop(self):
        print("Stop Write Thread... =",self.name)
        self.terminate()



class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.threadRead  = readThread(1,"Reading Thread-1")
        self.threadWrite  = writeThread(1,"Writing Thread-1")

    #Set Communication State
    setCommunicationState = Signal(bool)
    #Set WriteMessageLog Signal
    writeMessageLog = Signal(str)


    countTest = 0

    #Function Set Name to Label
    @Slot(bool)
    def startCommunication(self,state):
        if state == True:
            self.threadRead.start()
            self.threadWrite.start()
        else:
            self.threadRead.stop()
            self.threadWrite.stop()

        self.setCommunicationState.emit(state)


    @Slot(str)
    def writeMessageLogFunc(self,byteArray):
        self.writeMessageLog.emit(str(self.countTest))
        self.countTest = self.countTest  + 1




if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    #Get Contex from UI
    main = MainWindow()
    engine.rootContext().setContextProperty("backendCommunication",main) #UI ile Oluşturdugumuz class bağlanıyor

    #Load QML File
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

