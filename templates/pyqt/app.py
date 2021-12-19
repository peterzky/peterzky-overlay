import sys
from PySide2.QtWidgets import QPushButton, QApplication, QMainWindow


class Window(QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.btn = QPushButton("hi")
        self.setCentralWidget(self.btn)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    w = Window()
    w.show()
    sys.exit(app.exec_())
