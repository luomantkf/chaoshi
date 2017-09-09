package com.chaoshi.servlet;

import com.chaoshi.dao.BgGoodDao;
import com.chaoshi.dao.FgOrderDao;
import com.chaoshi.dao.FgPayDao;
import com.chaoshi.model.*;
import com.chaoshi.util.DbUtil;
import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 *商品的处理类
 */
public class FgOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    FgOrderDao orderDao=new FgOrderDao();
    FgPayDao payDao=new FgPayDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        HttpSession session = null;
        Connection con = null;
        //更改购买数量
        if (request.getParameter("action").equals("1")) {
            session=request.getSession();
            try {
                con=dbUtil.getCon();
                List<FgOrderVo> orderVos=(List<FgOrderVo>)session.getAttribute("orderVos");
                for(int i=0;i<orderVos.size();i++) {
                    FgOrderVo orderVo = orderVos.get(i);
                    orderVo.setCount(Integer.parseInt(request.getParameter("count"+i)));
                    orderVo.setMoney(Integer.parseInt(request.getParameter("count"+i))*orderVo.getPrice());
                    orderDao.updateOrderMoney(con,orderVo);

                }
                response.sendRedirect("/jsp/fg/fg-shoppingCart.jsp");
            } catch (Exception e) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.history.back(-1)</script>");
                return;
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        //订单支付
        if (request.getParameter("action").equals("2")) {
            try {
                con=dbUtil.getCon();
                FgOrder order=null;
                String payId=request.getParameter("payId");
                short payType=Short.parseShort(request.getParameter("payType"));
                String[] strs1=payId.split("0b1cHa");
                String payTime=strs1[0];
                String orderIds=strs1[1];

                FgPay pay=new FgPay();
                pay.setPayId(payId);
                pay.setOrderIds(orderIds);
                pay.setPayTime(payTime);
                pay.setPayType(payType);
                int pId=payDao.insertFgOrder(con,pay);
                if (pId!=-1){
                    String[] strs2=orderIds.split("Ha");
                    for(int i=0;i<strs2.length;i++){
                        order=new FgOrder();
                        order.setId(Integer.parseInt(strs2[i]));
                        order.setStatus("1");
                        order.setpId(pId);
                        if(!orderDao.updateOrderStatus(con,order)){
                            PrintWriter pw = response.getWriter();
                            pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                            return;
                        }
                     }
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"购买成功\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                    return;
                }

            } catch (Exception e) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                return;
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                }
            }

        }
        //分页显示订单
        else if(request.getParameter("action").equals("3")){
            HashMap<String,Object> result=new HashMap<String,Object>();
            session=request.getSession();
            try {
                con=dbUtil.getCon();
                Integer allPage=0;
                Integer startNUm=0;
                Integer pageNum=6;
                FgUser user=(FgUser)session.getAttribute("currentUser");
                if(orderDao.getNum(con,user.getId())!=-1){
                    allPage=orderDao.getNum(con,user.getId());
                }
                Integer currentPage= null;
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                startNUm=(currentPage-1)*pageNum;
                List<FgOrderVo> list=null;
                list = orderDao.listFgOrderVo1(con,user.getId(), startNUm, pageNum);
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
        //分页清空购物车
        else if(request.getParameter("action").equals("4")){
            try {
                con=dbUtil.getCon();
                String orderIds=request.getParameter("orderIds");
                String[] orderidss=orderIds.split("_");
                for(int i=0;i<orderidss.length;i++){
                    String orderId=orderidss[i];
                    orderDao.deleteFgOrder(con,Integer.parseInt(orderId));
                }
            } catch (Exception e) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                return;
            }
            response.sendRedirect("/jsp/fg/fg-shoppingCart.jsp");
        }
        //后台分页显示订单
        else if(request.getParameter("action").equals("5")){
            HashMap<String,Object> result=new HashMap<String,Object>();
            session=request.getSession();
            try {
                con=dbUtil.getCon();
                Integer allPage=0;
                Integer startNUm=0;
                Integer pageNum=6;
                if(orderDao.getNum(con)!=-1){
                    allPage=orderDao.getNum(con);
                }
                Integer currentPage= null;
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                startNUm=(currentPage-1)*pageNum;
                List<FgOrderVo> list=null;
                list = orderDao.listFgOrderVo3(con, startNUm, pageNum);
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

        //删除订单
        else if(request.getParameter("action").equals("6")){
            Integer id=Integer.parseInt(request.getParameter("id"));
            try {
                con = dbUtil.getCon();
                if (orderDao.deleteFgOrder(con,id)) {
                    PrintWriter pw = response.getWriter();
                    if("1".equals(request.getParameter("type"))){
                        pw.print("<script>alert(\"删除成功\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                    }else {
                        pw.print("<script>alert(\"删除成功\");window.location.href=\"/jsp/bg/bg-orders.jsp\"</script>");
                    }
                    return;
                } else {
                    PrintWriter pw = response.getWriter();
                    if("1".equals(request.getParameter("type"))){
                        pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-shoppingCart.jsp\"</script>");
                    }else {
                        pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-orders.jsp\"</script>");
                    }
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
        //更改订单的状态
        else if(request.getParameter("action").equals("7")){
            try {
                con = dbUtil.getCon();
                int status=Integer.parseInt(request.getParameter("status"));
                if(status==1){
                    response.sendRedirect("/jsp/bg/bg-orders.jsp");
                }else{
                    Integer id=Integer.parseInt(request.getParameter("id"));
                    int status1=orderDao.getStatus(con,id);
                    if(status1==status){
                        response.sendRedirect("/jsp/bg/bg-orders.jsp");
                    }else {
                        FgOrder order=new FgOrder();
                        order.setId(id);
                        order.setStatus("2");
                        if(orderDao.updateOrderStatus1(con,order)){
                            PrintWriter pw = response.getWriter();
                            pw.print("<script>alert(\"发货成功\");window.location.href=\"/jsp/bg/bg-orders.jsp\"</script>");
                            return;
                        }
                    }
                }
            } catch (Exception e) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-orders.jsp\"</script>");
                return;

            }



        }
        //退款
        else if(request.getParameter("action").equals("8")){
            Integer id=Integer.parseInt(request.getParameter("orderId"));
            try {
                con = dbUtil.getCon();
                if (orderDao.deleteFgOrder(con, id)) {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"退款成功\");window.location.href=\"/jsp/fg/fg-cartDetail.jsp\"</script>");
                    return;
                } else {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-cartDetail.jsp\"</script>");
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

