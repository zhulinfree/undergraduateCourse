#-*-coding:utf-8-*-
import web
import os
import json
from model import *

urls = (
    '/', 'hello',
    '/login', 'login',
    '/regist', 'regist',
    '/getTip','getTip',
    '/getMyGoods','getMyGoods',
    '/publish','publish',
    '/delete','delete',
    '/search','search',
    '/wave', 'wave',
    '/getMyStore', 'getMyStore',
    '/store', 'store',
    '/deletestore', 'deletestore',
    '/isstored', 'isstored',
    '/update','update',
    '/getInfo','getInfo'
)
class hello:
    def GET(self):
        return 'hello world'

   
class login:
    def GET(self):
        con = Connect()
        query='select * from register_and_login where userID="niexiaoning"'
        ok = Exec(con,query)
        return ok[0][2]
       
        
    def POST(self):
        para = web.input()
        username = para['username']
        password = para['password']
        con = Connect()
        query='select * from register_and_login where userID="'+str(username)+'"'
        ok = Exec(con,query)
        if len(ok)==0:
            return 'no'
        else:
            if ok[0][1]==password:
                return ok[0][2]
            else:
                return 'no'
        
class regist:
    def GET(self):
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        username = para['username']
        password = para['password']
        nickname = para['nickname']
        u=str(username)
        p=str(password)
        n=nickname
        query='insert into register_and_login values("'+u+'","'+p+'","'+n+'")'                
        #TODO:...
        con = Connect()
        try:
        	ok = Exec(con,query)            
        except:
            return 'no'
        
        con.commit()
        return 'ok'
    
class getTip:
    def GET(self):
        con = Connect()
        query='select * from goods where classifi="book"'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s
    
    def POST(self):
        para = web.input()
        gclass = para['goods_class']
        con = Connect()
        query='select * from goods where classifi="'+str(gclass)+'"'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s
    
class getMyGoods:
    def GET(self):
        con = Connect()
        query='select * from goods where userID="niexnn"'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s
    
    def POST(self):
        para = web.input()
        userId = para['userId']
        con = Connect()
        query='select * from goods where userID="'+str(userId)+'"'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s  

class publish:
    def GET(self):
        query='insert into goods(imgURL,name,description,classifi,contact_me,userID,latitude,longitude) values("  ","新东方四级词汇绿宝书","价格面议","book","18560622289","niexn","123.1341","23.4535")'
        con = Connect()
        ok = Exec(con,query)
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        pic = para['pic']
        name = para['name']
        des = para['des']
        gclass = para['gclass']
        contact = para['contact']
        userId = para['userId']
        lati = para['lati']
        longi = para['longi']
        
        #query='insert into goods(imgURL,name,description,classifi,contact_me,userID,latitude,longitude) values("'+str(pic)+'","'+str(name)+'","'+str(des)+'","book","'+str(contact)+'","niexn","123.1341","23.4535")'
        query='insert into goods(imgURL,name,description,classifi,contact_me,userID,latitude,longitude) values("'+pic+'","'+name+'","'+des+'","'+str(gclass)+'","'+contact+'","'+str(userId)+'","'+str(lati)+'","'+str(longi)+'")'
        con = Connect()
        try:
        	ok = Exec(con,query)
        except:
            return 'no'
        
        con.commit()
        return 'ok'
    
    
    
    
class update:
    def GET(self):
        query='insert into personalInfo(userId,realName,sex,school,phone) values("19283","xx","男","zhuhai","1372623")'
        con = Connect()
        ok = Exec(con,query)
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        realName = para['realName']
        sex = para['sex']
        sclass = para['sclass']
        phone= para['phone']
        userId = para['userId']       
        select='select * from personalInfo where userId="'+str(userId)+'"'
        con = Connect()
        sel=Exec(con,select);
        if len(sel)==0:
            query='insert into personalInfo(userId,realName,school,phone,sex) values("'+str(userId)+'","'+str(realName)+'","'+str(sclass)+'","'+str(phone)+'","'+sex+'")'     
        else:
        	query='update personalInfo set realName="'+str(realName)+'",school="'+str(sclass)+'",phone="'+str(phone)+'",sex="'+sex+'" where userId="'+str(userId)+'" '
                       
        try:
        	ok = Exec(con,query)
        except:
            return 'no'
        
        con.commit()
        return 'ok'

   
   
class getInfo:
    def GET(self):
        con = Connect()
        query='select * from personalInfo where userID="niexiaoning"'
        ok = Exec(con,query)
        data=dict();      
        return ok[0][4]
       
        
    def POST(self):
        para = web.input()
        userId = para['userId']        
        con = Connect()
        query='select * from personalInfo where userID="'+str(userId)+'"'
        ok = Exec(con,query)       
        data=dict();
        s="["
        data['school']=res[0][1]
        data['sex']=res[0][2]            
        data['realName']=res[0][3]
        data['phone']=res[0][4]                     
        s=s+json.dumps(data)
        s=s+']'
        return s
          
    
class delete:
    def GET(self):
        query='delete from goods where goods_id=3'
        con = Connect()
        ok = Exec(con,query)
        con.commit()
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        goods_id = para['id']
        query='delete from goods where goods_id="'+str(goods_id)+'"'
        con = Connect()
        ok = Exec(con,query)
        con.commit()
        return 'ok'

class search:
    def GET(self):
        con = Connect()
        gclass='分'
        query='select * from goods where name like "%'+str(gclass)+'%" or description like "%'+str(gclass)+'%"'
        
        res = Exec(con,query)
        return len(res)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s
    
    def POST(self):
        para = web.input()
        gclass = para['info']
        con = Connect()
        query='select * from goods where description like "%'+gclass+'%" or name like "%'+gclass+'%"'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s 

class wave:
    def GET(self):
        con = Connect()
        query='select * from goods'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s 
   
    def POST(self):
        para = web.input()
        con = Connect()
        query='select * from goods'
        res = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(res)):
            data['id']=res[i][0]
            data['name']=res[i][2]
            data['pic']=res[i][1]
            data['gclass']=res[i][4]
            data['des']=res[i][3]
            data['contact']=res[i][5]
            data['lati']=res[i][7]
            data['longi']=res[i][8]
            if i!=len(res)-1:
            	s=s+json.dumps(data)+',';
            else:
            	s=s+json.dumps(data)
        s=s+']'
        return s 
    
class getMyStore:
    def GET(self):
        con = Connect()
        query='select * from collection where userID="niexn"'
        ok = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(ok)):
            goods_id=ok[i][1]
            query1='select * from goods where goods_id="'+str(goods_id)+'"'
            res = Exec(con,query1)
            if(len(res)>0):
                data['id']=res[0][0]
                data['name']=res[0][2]
                data['pic']=res[0][1]
                data['gclass']=res[0][4]
                data['des']=res[0][3]
                data['contact']=res[0][5]
                data['lati']=res[0][7]
                data['longi']=res[0][8]
                if i!=len(ok)-1:
                    s=s+json.dumps(data)+',';
                else:
                    s=s+json.dumps(data)
        if(s[len(s)-1]==','):
            s=s[0:len(s)-1]
        s=s+']'
        return s
    
    def POST(self):
        para = web.input()
        userId = para['userId']
        con = Connect()
        query='select * from collection where userID="'+str(userId)+'"'
        ok = Exec(con,query)
        data=dict()
        s="["
        for i in range (len(ok)):
            goods_id=ok[i][1]
            query1='select * from goods where goods_id="'+str(goods_id)+'"'
            res = Exec(con,query1)
            if(len(res)>0):
                data['id']=res[0][0]
                data['name']=res[0][2]
                data['pic']=res[0][1]
                data['gclass']=res[0][4]
                data['des']=res[0][3]
                data['contact']=res[0][5]
                data['lati']=res[0][7]
                data['longi']=res[0][8]
                if i!=len(ok)-1:
                    s=s+json.dumps(data)+',';
                else:
                    s=s+json.dumps(data)
        if(s[len(s)-1]==','):
            s=s[0:len(s)-1]
        s=s+']'
        return s


class store:
    def GET(self):
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        userId = para['userId']
        goods_id = para['id']
        query='insert into collection values("'+str(userId)+'","'+str(goods_id)+'")'
        #TODO:...
        con = Connect()
        try:
        	ok = Exec(con,query)
        except:
            return 'no'
        
        con.commit()
        return 'ok'  
        
class deletestore:
    def GET(self):
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        userId = para['userId']
        goods_id = para['id']
        query='delete from collection where userID="'+str(userId)+'" and goods_id="'+str(goods_id)+'"'
        con = Connect()
        try:
        	ok = Exec(con,query)
        except:
            return 'no'
        
        con.commit()
        return 'ok' 
        
class isstored:
    def GET(self):
        return 'ok'
        
    
    def POST(self):
        para = web.input()
        userId = para['userId']
        goods_id = para['id']
        query='select * from collection where userID="'+str(userId)+'" and goods_id="'+str(goods_id)+'"'
        con = Connect()
        ok = Exec(con,query)
        if(len(ok)>0):
        	return 'ok'
        else:
        	return 'no'
        
         
app = web.application(urls,globals()).wsgifunc()
application = sae.create_wsgi_app(app)



#def application(environ, start_response):
 #   start_response('200 ok', [('content-type', 'text/plain')])
  #  return ['Hello, SAE!']