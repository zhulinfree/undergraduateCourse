#-*-coding:utf-8-*-
import sae.const
import MySQLdb

HOST = sae.const.MYSQL_HOST
USER = sae.const.MYSQL_USER
PASSWD = sae.const.MYSQL_PASS
DB = sae.const.MYSQL_DB
PORT = int(sae.const.MYSQL_PORT)


def Connect():
    
    con = MySQLdb.connect (host=HOST,user=USER,passwd=PASSWD,db=DB,port=PORT,charset='utf8')
    return con

def Exec(con,query):
    cur = con.cursor()
    cur.execute(query)
    res = cur.fetchall()
    return res