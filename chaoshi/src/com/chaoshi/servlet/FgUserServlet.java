package com.chaoshi.servlet;

import com.chaoshi.dao.FgUserDao;
import com.chaoshi.model.FgUser;
import com.chaoshi.util.DbUtil;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;

/**
 *增加用户的处理类
 */
public class FgUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    FgUserDao userDao=new FgUserDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        HttpSession session=null;
        Connection con=null;


        //action为1用户进行注册
        if(request.getParameter("action").equals("1")){
            session=request.getSession();
            FgUser user=new FgUser();
            user.setUserName(request.getParameter("userName"));
            user.setPassword(request.getParameter("password"));
            user.setGrade(request.getParameter("grade"));
            user.setSushe(request.getParameter("sushe"));
            user.setPhone(request.getParameter("phone"));
            try {
                con=dbUtil.getCon();
                int userId=userDao.insertFgUser(con,user);
                if(userId!=-1){
                    user.setId(userId);
                    session.setAttribute("currentUser", user);
                    request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
                }else{

                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-UserRegister.jsp\"</script>");
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //数据删除
        else if(request.getParameter("action").equals("2")){
            Integer id=Integer.parseInt(request.getParameter("id"));
            try {
                con = dbUtil.getCon();
                if (userDao.deleteBgUser(con,id)) {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"删除成功\");window.location.href=\"/jsp/bg/bg-user.jsp\"</script>");
                    return;
                } else {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-user.jsp\"</script>");
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //登录验证
        if(request.getParameter("action").equals("3")){
            session=request.getSession();

            FgUser user=new FgUser();
            user.setUserName(request.getParameter("userName"));
            user.setPassword(request.getParameter("password"));

            try {
                con = dbUtil.getCon();
                if(userDao.loginFgUser(con,user)!=0) {
                    user.setId(userDao.loginFgUser(con, user));
                    session.setAttribute("currentUser", user);
                    request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
                }else {
                    if(userDao.loginFgUser(con,user.getUserName())){
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"用户不存在\");window.location.href=\"/jsp/index.jsp\"</script>");
                        return;
                    }else {
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"密码有误\");window.location.href=\"/jsp/index.jsp\"</script>");
                        return;
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //后台显示用户
        if(request.getParameter("action").equals("4")){
            HashMap<String,Object> result=new HashMap<String,Object>();
            try {
                con=dbUtil.getCon();
                Integer allPage=0;
                Integer startNUm=0;
                Integer pageNum=7;
                if(userDao.getNum(con)!=0){
                    allPage=userDao.getNum(con);
                }
                Integer currentPage= null;
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                startNUm=(currentPage-1)*pageNum;
                List<FgUser> list=null;
                list=userDao.listFgUser(con, startNUm, pageNum);
                result.put("pageNum",pageNum.toString());
                result.put("allNum",allPage.toString());
                result.put("model",list);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            //将map对象转换成json对象，引用了google相应的包
            Gson gson=new Gson();
            PrintWriter pw = response.getWriter();
            pw.write(gson.toJson(result));
            pw.close();
        }
        //查看前台用户信息
        if(request.getParameter("action").equals("5")){
            session=request.getSession();
            FgUser user=(FgUser)session.getAttribute("currentUser");

            try {
                con = dbUtil.getCon();
                if(user!=null){
                    user=userDao.selectFgUserById(con,user.getId());
                    request.setAttribute("user",user);
                    request.getRequestDispatcher("/jsp/fg/fg-updateUser.jsp").forward(request,response);
                }
                else{
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/index.jsp\"</script>");
                    return;
                }
            } catch (Exception e) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/index.jsp\"</script>");
                return;
            }
        }
        if(request.getParameter("action").equals("6")){
            session=request.getSession();
            FgUser user=(FgUser)session.getAttribute("currentUser");
            user.setId(Integer.parseInt(request.getParameter("id")));
            user.setGrade(request.getParameter("grade"));
            user.setSushe(request.getParameter("sushe"));
            user.setPhone(request.getParameter("phone"));
            try {
                con=dbUtil.getCon();
                if(userDao.updateUserById(con,user)){
                    session.setAttribute("currentUser", user);
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"更改信息成功\");window.location.href=\"/jsp/index.jsp\"</script>");
                    return;
                }else{

                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"jsp/index.jsp\"</script>");
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

