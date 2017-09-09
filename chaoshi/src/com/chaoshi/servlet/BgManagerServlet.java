package com.chaoshi.servlet;

import com.chaoshi.dao.BgManagerDao;
import com.chaoshi.model.BgManager;
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
 *增加管理员的处理类
 * action：1增，2删除，3查，4登录验证
 */
public class BgManagerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    BgManagerDao managerDao=new BgManagerDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Connection con = null;
        //action为1增加管理员
        if(request.getParameter("action").equals("1")){
            BgManager user = new BgManager();
            user.setUserName(request.getParameter("userName"));
            user.setPassword(request.getParameter("password"));
            user.setPhone(request.getParameter("phone"));
            {
                try {
                    con = dbUtil.getCon();
                    if (managerDao.insertBgManager(con, user)) {
                        session.setAttribute("currentManager", user);
                        request.getRequestDispatcher("/jsp/bg/bg-managerSelect.jsp").forward(request, response);
                    } else {

                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-managerSelect.jsp\"</script>");
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
        //数据删除
        else if(request.getParameter("action").equals("2")){
            Integer id=Integer.parseInt(request.getParameter("id"));
            try {
                con = dbUtil.getCon();
                if (managerDao.deleteBgManager(con,id)) {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"删除成功\");window.location.href=\"/jsp/bg/bg-managerSelect.jsp\"</script>");
                    return;
                } else {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-managerSelect.jsp\"</script>");
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
        //分页显示管理员
        else if(request.getParameter("action").equals("3")){
            HashMap<String,Object> result=new HashMap<String,Object>();
            try {
                con=dbUtil.getCon();
                Integer allPage=0;
                Integer startNUm=0;
                Integer pageNum=7;
                if(managerDao.getNum(con)!=0){
                    allPage=managerDao.getNum(con);
                }
                Integer currentPage= null;
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                startNUm=(currentPage-1)*pageNum;
                List<BgManager> list=null;
                list=managerDao.listBgManager(con,startNUm,pageNum);
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
    //登录验证
        else if(request.getParameter("action").equals("4")){
            BgManager manager = new BgManager();
            manager.setUserName(request.getParameter("managerName"));
            manager.setPassword(request.getParameter("password"));
            try {
                con = dbUtil.getCon();
                if(managerDao.loginManager(con, manager)!=0) {
                    manager.setId(managerDao.loginManager(con, manager));
                    session.setAttribute("currentManager", manager);
                    request.getRequestDispatcher("/jsp/bg/bg-managerSelect.jsp").forward(request, response);
                }else {
                    if (managerDao.loginManager(con,manager.getUserName())){
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"用户不存在\");window.location.href=\"/jsp/bg/bg-land.jsp\"</script>");
                        return;
                    }else {
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"密码有误\");window.location.href=\"/jsp/bg/bg-land.jsp\"</script>");
                        return;
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

