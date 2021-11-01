import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import QWidget,QScrollArea, QTableWidget, QVBoxLayout,QTableWidgetItem
from PyQt5.QString import QString

###### 키워드 검색 창
class SearchDialog(QDialog):
    global joong_crawl
    global han_crawl

    def __init__(self):
        super().__init__()
        self.setupUI()
        self.keyword = None
        self.page_num = None

    def setupUI(self): #기본적인 레이아웃 설정
        self.setGeometry(1100, 200, 500, 300)
        self.setWindowTitle("Input News Keyword & Page number")
        self.setWindowIcon(QIcon("web.png"))
        ###
        #grid = QGridLayout()
        #grid.addWidget(self.createSearchBoxGroup(),)
        ###
        label1 = QLabel("Key Word: ")
        label2 = QLabel("Page Number: ")

        self.lineEdit1 = QLineEdit()
        self.lineEdit2 = QLineEdit()
        self.pushButton1 = QPushButton("Search")
        self.pushButton1.clicked.connect(self.pushButtonClicked)

        layout = QGridLayout()
        layout.addWidget(label1,0,0)
        layout.addWidget(self.lineEdit1,0,1)
        layout.addWidget(self.pushButton1,3,1)
        layout.addWidget(label2,1,0)
        layout.addWidget(self.lineEdit2,1,1)
        self.setLayout(layout)

    def pushButtonClicked(self):
        self.keyword = self.lineEdit1.text()
        self.page_num = self.lineEdit2.text()
        self.close()

class MyWindow(QWidget): #처음 띄울 창(검색 시작하기)
    def __init__(self):
        super().__init__()
        self.setupUI()

    def setupUI(self): #화면 구조 설계
        self.setGeometry(800, 200, 600, 700)
        self.setWindowTitle("Unbiased News Program made by me!")
        self.setWindowIcon(QIcon('web.png'))

        self.setStyleSheet(QString("background: yellow"))


        self.pushButton = QPushButton("Start Searching News")
        self.pushButton.clicked.connect(self.pushButtonClicked)
        self.label1 = QLabel()

        layout = QVBoxLayout()
        layout.addWidget(self.pushButton)
        layout.addWidget(self.label1)
        #layout.addWidget(self.label2)

        #scroll = QScrollArea()
        #scroll.setWidget(self.table1)
        #layout.addWidget(self.table1)
        #scroll.setWidget(self.table2)
        #layout.addWidget(self.table2)

        self.setLayout(layout)

    def pushButtonClicked(self):
        from news_crawling import joong_crawl, han_crawl
        dlg = SearchDialog()
        dlg.exec_()
        #크롤링 코드
        ######
        keyword = dlg.keyword
        page_num = dlg.page_num
        self.crawl_page = int(page_num)
        self.header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.220 Whale/1.3.51.7 Safari/537.36',
        }
        self.crawl_page = int(page_num)
        self.joong_data = joong_crawl(self.header, keyword, self.crawl_page)
        self.han_data = han_crawl(self.header, keyword, self.crawl_page)
        #크롤링 함수 임포트
        #from news_crawling import joong_crawl, han_crawl
        # 뉴스 기사 크롤링
        #from PyQt5.QtWidgets import QWidget, QScrollArea, QTableWidget, QVBoxLayout, QTableWidgetItem
        import pandas as pd
        #중앙일보 크롤링
        #joong_data = joong_crawl(header, keyword, crawl_page)
        #self.table1.setColumnCount(len(df_j.columns))
        #self.table1.setRowCount(len(df_j.index))
        #for i in range(len(df_j.index)):
        #    for j in range(len(df_j.columns)):
        #        self.table1.setItem(i, j, QTableWidgetItem(str(df_j.iloc[i, j])))
        #한겨래일보 크롤링
        #han_data = han_crawl(header, keyword, crawl_page)
        #self.table2.setColumnCount(len(df_h.columns))
        #self.table2.setRowCount(len(df_h.index))
        #for i in range(len(df_h.index)):
        #    for j in range(len(df_h.columns)):
        #        self.table2.setItem(i, j, QTableWidgetItem(str(df_h.iloc[i, j])))
        news = ""
        from news_crawling import clean_text
        for i in range(self.crawl_page * 10):
            news += "[" + str(self.joong_data['title'][i]) + "]" + "    " + str(self.joong_data['news'][i]) + "\n" + clean_text(
                str(self.joong_data['content'][i])) + "\n" + "*" * 50 + "\n\n"
            news += "[" + str(self.han_data['title'][i]) + "]" + "    " + str(self.han_data['news'][i]) + "\n" + clean_text(
                str(self.han_data['content'][i])) + "\n""*" * 50 + "\n\n"

        ######
        #self.label1.setText("Search Keyword '%s' with page number %s" % (keyword, page_num))
        #크롤링 결과 보여줄 코드
        self.label1.setText('%s를 키워드로 한 뉴스 기사\n\n%s' % (keyword, news[:200]))
        self.label1.scrollToBottom();



#class ShowWordCloud: #워드클라우드 보여줄 창
#    def

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MyWindow()
    window.show()
    app.exec_()